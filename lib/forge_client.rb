require 'pry'
require 'httpx'

API_BASE = "https://forge.sp-tarkov.com/api/v0"

class SPTForgeClient # TODO: handle response errors
  attr_accessor :http

  def initialize
    @http = HTTPX.with(headers: {
      authorization: "Bearer #{ENV["SPT_FORGE_TOKEN"]}"
    })
  end

  def get(url)
    @http.get("#{API_BASE}/#{url}")
  end

  def get_mod(mod_id)
    res = get("mod/#{mod_id}")
    JSON.parse(res.body, symbolize_names: true)
  end

  def get_mod_versions(mod_id)
    raw_res = get("mod/#{mod_id}/versions")
    res = JSON.parse(raw_res.body, symbolize_names: true)

    pages = res[:meta][:links]

    versions = []
    versions << res[:data]

    versions << pages.uniq.map do |page|
      next if page[:url].nil? || page[:active] || page[:label].include?("Next")
      binding.pry
      raw_page_res = get(page[:url])
      page_res = JSON.parse(raw_page_res.body, symbolize_names: true)
      # TODO: API error checking
      page_res[:data]
    end
    versions.flatten!.uniq!.compact!

    versions
  end

  def get_mod_latest_version(mod_id)
    get_mod_versions(mod_id).sort_by { |i| i[:version] }.reverse.first
  end
end
