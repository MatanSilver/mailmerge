# frozen_string_literal: true

require_relative "mailmerge/version"
require 'net/smtp'
require 'csv'
require 'erb'
require 'open3'
require 'optionparser'
include Open3

module Mailmerge
  class Error < StandardError; end

  smtp = Net::SMTP.new 'smtp.gmail.com', 587
  smtp.enable_starttls
  arr_of_rows = CSV.read(ARGV[0])
  email_template = ARGV[1]
  headers = arr_of_rows[0]
  rows = arr_of_rows[1..]
  template_contents = File.read(ARGV[1])
  user_email = ARGV[2]
  user_password = ARGV[3]

  class TemplateData < ERB
    def initialize(keys, values, template)
      @template = template
      keys.each_with_index do |key, idx|
        self.instance_variable_set("@" + key, values[idx])
      end
      super(@template)
    end

    def result
      super(binding)
    end
  end

  renderer = ERB.new(template_contents)
  rows.each do |row|
    td = TemplateData.new(headers, row, template_contents)
    rendered_email = td.result
    puts rendered_email
    smtp.start('gmail.com',
               user_email, user_password, :plain) do |smtp|
      smtp.send_message rendered_email,
                        user_email,
                        td.instance_variable_get("@to_email")
    end
    puts "-------------------------"
  end
end
