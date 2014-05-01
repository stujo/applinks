#Applinks

A gem to help build applinks compliant meta tags into your rails app pages

This is a new project, please fork and submit pull requests to help!

[https://github.com/stujo/applinks](https://github.com/stujo/applinks)

Cheers!

[![Gem Version](https://badge.fury.io/rb/applinks.svg)](http://badge.fury.io/rb/applinks)

#Usage

##Installation

In Gemfile:

```
gem 'applinks'

```

```
bundle install

```

Should load the gem

##Sample Application Layout

Use the applinks helper in your layout

```
<!DOCTYPE html>
<html>
<head>
  <title>ApplinksDemo</title>
  <%= stylesheet_link_tag "application", media: "all", "data-turbolinks-track" => true %>
  <%= javascript_include_tag "application", "data-turbolinks-track" => true %>
  <%= csrf_meta_tags %>
  <%= applinks({
                       ios: {
                               url: 'myapp://docs_for_me',
                               app_store_id: '123456',
                               app_name: 'My IOS App Name'
                       },
                       ipad: {
                               url: 'myapp://docs_for_me',
                               app_store_id: 'ipad1234567',
                               app_name: 'My iPad App Name'
                       },
                       iphone: {
                               url: 'myapp://docs_for_me',
                               app_store_id: 'iphone1234568',
                               app_name: 'My iPhone App Name'
                       },
                       android: {
                               url: 'myapp://docs_for_me',
                               package: 'org.example.package',
                               app_name: 'My Android AppName'
                       },
                       windows_phone: {
                               url: 'myapp://docs_for_me',
                               app_id: 'wpAppId',
                               app_name: 'My Windows Phone AppName'
                       },
                       web: {
                               url: 'http://example.org/fallback.html',
                               should_fallback: true
                       }

               }) %>
</head>
<body>

<%= yield %>

</body>
</html>
```


