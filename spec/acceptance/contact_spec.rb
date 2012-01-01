# encoding: UTF-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Contact" do
  scenario "should send contact notification" do
    email, message = "vince@stub.net", "kawa i papierosy"
    @user.visit(contact_page)
    @user.fill_in("contact_name", with: "Wincenty Kadłubek")
    @user.fill_in("contact_email", with: email)
    @user.click("Wyślij")
    @user.should_see_translated("contacts.message_not_sent_due_to_errors")
    @user.fill_in("contact_message", with: message)
    @user.click("Wyślij")
    @user.should_see_translated("contacts.message_sent_successfuly")
    @mail_system.should_send_email(to: AppConfig[:contact_email], from: email, message: message)
  end

  scenario "should show 'Drug online' snippet" do
    content = "giithub.com/dopalacze"
    @website.has(:published_snippet, label: :online, content: content)
    @user.visit(contact_page)
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.online')
    end
  end

  scenario "should show 'Ruby in Poland' snippet" do
    content = "forum Ruby"
    @website.has(:published_snippet, label: :community, content: content)
    @user.visit(contact_page)
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.community')
    end
  end

  scenario "should show 'Keep in touch' snippet" do
    content = "RSS"
    @website.has(:published_snippet, label: :community, content: content)
    @user.visit(contact_page)
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.keep_in_touch')
    end
  end

  scenario "should show last published news article" do
    title, body = 'snow', 'snowman'
    at_time 1.day.ago do
      @website.has(:published_news_article, title: title, body: body)
    end
    at_time 1.month.ago do
      @website.has(:published_news_article)
    end
    @website.has(:news_article)
    @user.visit(contact_page)
    within "aside" do
      @user.should_see(title).should_see(body)
      @user.should_see_translated('news_articles.read_more')
    end
  end
end
