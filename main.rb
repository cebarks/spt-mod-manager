#!/usr/bin/env ruby

require 'pry'

require_relative 'lib/client'

client = SPTForgeClient.new

version = client.get_mod_latest_version(791)

pp version
