require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'mail_tester'

describe MailTester do
  before(:all) do
    config_file = "config.yml"

    unless File.exist? config_file
      puts "#{config_file} is missing!"
      exit
    end

    @config = YAML::load(File.open(config_file))
  end

  before(:each) do
    @test = MailTester.new(@config['email_adress'], @config['password'])
  end

  it "Can define parameters" do
    @test.email.should == @config['email_adress']
    @test.password.should == @config['password']
  end

  it "Can split mail" do
    @test.user.should == @config['user']
    @test.domain.should == @config['domain']
  end

  it "Can define correct servers" do
    @test.pop3_hostname.should == @config['server_pop']
    @test.smtp_hostname.should == @config['server_smtp']
  end

  it "Can check mail" do
    (message, nb) = @test.check_mail

    message.should =~ /^([0-9]+ mails popped.|No mail.)$/
    nb.should be_an_instance_of(Fixnum)
    nb.to_s.should =~ /^[0-9]+$/
  end

  it "Can test server" do
    (message, nbefore) = @test.check_mail
    (result, id) = @test.check_smtp
    nbs = @test.search_mail(id)
    nbd = @test.delete_mail(id)
    (message, nafter) = @test.check_mail

    result.should == 'Mail sent'
    id.should =~ /^Message-Id: /

    nbs.should be_an_instance_of(Fixnum)
    nbd.should be_an_instance_of(Fixnum)

    nbefore.should >= nafter
  end

  it "Can't make bad search" do
    id = "Message-Id: <2010-02-14T23:44:52+01:00@bob@example.com>"
    nbs = @test.search_mail(id)
    nbd = @test.delete_mail(id)

    nbs.should == -1
    nbd.should == -1
  end

  it "Can use a empty account" do
    @test = MailTester.new(@config['dum_mail'], @config['dum_pass'])
    (message, nb) = @test.check_mail

    message.should =~ /^No mail.$/
    nb.should be_nil
    id = "Message-Id: <2010-02-14T23:44:52+01:00@bob@example.com>"
    nbs = @test.search_mail(id)
    nbd = @test.delete_mail(id)
  end
end
