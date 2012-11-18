require 'net/pop'
require 'net/smtp'
require 'date'

class MailTester
  attr_reader :email, :password, :user, :domain, :pop3_hostname, :smtp_hostname, :pop3_server, :smtp_server
  #attr_accessor :email, :password, :user, :domain

  def initialize(email, password, realname="")
    @email = email
    @password = password
    @realname = realname

    @user, @domain = @email.split('@')
    @pop3_hostname = 'pop.' + @domain
    @smtp_hostname = 'smtp.' + @domain

    @pop3_server = Net::POP3.new(@pop3_hostname)
    @smtp_server = Net::SMTP.start(@smtp_hostname, 587)
  end

  def check_mail
    result = ''
    @pop3_server.start(@email, @password)
    if @pop3_server.mails.empty?
      result += 'No mail.'
    else
      i = 0
      @pop3_server.each_mail do |m|
        i += 1
      end
      result += "#{@pop3_server.mails.size} mails popped."
    end
    @pop3_server.finish()

    return [result, i]
  end

  def search_mail(search)
    result = 0
    @pop3_server.start(@email, @password)
    if @pop3_server.mails.empty?
      result = 0
    else
      pattern = Regexp.new(search.gsub(/[:+]/, '.'))
      @pop3_server.each_mail do |m|
        result += 1
        if m.header() =~ pattern
          @pop3_server.finish()
          return result
        end
      end
    end
    @pop3_server.finish()

    return -1
  end

  def delete_mail(search)
    result = 0
    @pop3_server.start(@email, @password)
    if @pop3_server.mails.empty?
      result = 0
    else
      pattern = Regexp.new(search.gsub(/[:+]/, '.'))
      @pop3_server.each_mail do |m|
        result += 1
        if m.header() =~ pattern
          m.delete
          @pop3_server.finish()
          return 1
        end
      end
    end
    @pop3_server.finish()

    return -1
  end

  def check_smtp
    message_id = 'Message-Id: <' + DateTime::now.to_s + '@' + @email + '>'

    msgstr =  ''
    msgstr += "From: #{@realname} <#{@email}>\n"
    msgstr += "To: #{@realname} <#{@email}>\n"
    msgstr += "Subject: test message\n"
    msgstr += "Date: Sat, 23 Jun 2001 16:26:43 +0900\n"
    msgstr += "#{message_id}\n"
    msgstr += "\n"
    msgstr += "This is a test message."

    @smtp_server.send_message msgstr, @email, @email
    return ['Mail sent', message_id]
  end
end
