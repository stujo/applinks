#Applinks

A gem to help build applinks compliant meta tags into your rails app pages

This is a new project, please fork and submit pull requests to help!

[https://github.com/stujo/applinks](https://github.com/stujo/applinks)

Cheers!

[![Gem Version](https://badge.fury.io/rb/applinks.svg)](http://badge.fury.io/rb/applinks)

[![Build Status](https://travis-ci.org/stujo/applinks.svg?branch=master)](https://travis-ci.org/stujo/applinks)

[![Code Climate](https://codeclimate.com/github/stujo/applinks.png)](https://codeclimate.com/github/stujo/applinks)


#What Are Applinks?

A way for apps to link to each other across multiple devices

[http://applinks.org/documentation/](http://applinks.org/documentation/)

#Usage

Add to your Gemfile:

via `Gemfile`

```
gem 'applinks'
```

Run bundle install:

```
bundle install
```

Prior to VERSION = "0.1.4", the Applinks::ApplicationHelper needs to be included manually:

__This is not required > 0.1.4__

Include the `Applinks::ApplicationHelper` in your `ApplicationHelper`:

via `app/helpers/application_helper.rb`

```
module ApplicationHelper
  include Applinks::ApplicationHelper
end
```

Now add an applinks call to your layout:

via `app/views/layouts/application.html.erb`


```
<!DOCTYPE html>
<html>
<head>
<title>ApplinksDemo</title>
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

This would generate the following HTML:

```

<!DOCTYPE html>
<html>
<head>
<title>ApplinksDemo</title>
<meta property="al:ios:url" content="myapp://docs_for_me"/>
<meta property="al:ios:app_store_id" content="123456"/>
<meta property="al:ios:app_name" content="My IOS App Name"/>

<meta property="al:iphone:url" content="myapp://docs_for_me"/>
<meta property="al:iphone:app_store_id" content="iphone1234568"/>
<meta property="al:iphone:app_name" content="My iPhone App Name"/>

<meta property="al:ipad:url" content="myapp://docs_for_me"/>
<meta property="al:ipad:app_store_id" content="ipad1234567"/>
<meta property="al:ipad:app_name" content="My iPad App Name"/>

<meta property="al:android:url" content="myapp://docs_for_me"/>
<meta property="al:android:app_name" content="My Android AppName"/>
<meta property="al:android:package" content="org.example.package"/>

<meta property="al:windows_phone:url" content="myapp://docs_for_me"/>
<meta property="al:windows_phone:app_name" content="My Windows Phone AppName"/>
<meta property="al:windows_phone:app_id" content="wpAppId"/>

<meta property="al:web:url" content="http://example.org/fallback.html"/>
</head>
<body>
Hello World
</body>
</html>
```

#Default Values

You can specify default values which will be used on all pages in  ``config/initializers/applinks.rb``

The defaults are only used for non-versioned applinks and are only rendered if the hash supplied to ``applinks()`` 
in the template includes the appropriate parent key like ``ios`` or ``ipad``. If the top level key is missing from 
the hash supplied to ``applinks()`` then the default values for that key are ignored



```
Applinks::Config.config do |config|

  config.defaults= {
      ios: {
          app_store_id: '123456DEFAULT',
          app_name: 'IOS Default App Name'
      },
      ipad: {
          app_store_id: 'ipad1234567DEFAULT',
          app_name: 'My Default iPad App Name'
      },
      iphone: {
          app_store_id: 'iphone1234568DEFAULT',
          app_name: 'DMy iPhone App Name'
      },
      android: {
          package: 'org.example.package.default',
          app_name: 'My Default Android AppName'
      },
      windows_phone: {
          app_id: 'wpAppIdDefault',
          app_name: 'My Default Windows Phone AppName'
      },
      web: {
          url: 'http://example.org/default_fallback.html',
      }

  }

end
```



