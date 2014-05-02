require 'spec_helper'

describe ApplicationHelper do

  IOS_URL_TAG = '<meta property="al:ios:url" content="xyz://docs" />'
  IOS_APP_TAG = '<meta property="al:ios:app_name" content="Stu Test App" />'
  IOS_STORE_TAG = '<meta property="al:ios:app_store_id" content="STUJO123" />'

  IOS_DATA = {ios:
                  {
                      url: 'xyz://docs',
                      app_name: 'Stu Test App',
                      app_store_id: 'STUJO123'
                  }
  }

  IPHONE_URL_TAG = '<meta property="al:iphone:url" content="ipxyz://docs" />'
  IPHONE_APP_TAG = '<meta property="al:iphone:app_name" content="Stu iPhone App" />'
  IPHONE_STORE_TAG = '<meta property="al:iphone:app_store_id" content="STuPHONE123" />'

  IPHONE_DATA = {iphone:
                     {
                         url: 'ipxyz://docs',
                         app_name: 'Stu iPhone App',
                         app_store_id: 'STuPHONE123'
                     }
  }


  IPAD_URL_TAG = '<meta property="al:ipad:url" content="ipadxyz://docs" />'
  IPAD_APP_TAG = '<meta property="al:ipad:app_name" content="Stu iPad App" />'
  IPAD_STORE_TAG = '<meta property="al:ipad:app_store_id" content="STuPAD123" />'

  IPAD_DATA = {ipad:
                   {
                       url: 'ipadxyz://docs',
                       app_name: 'Stu iPad App',
                       app_store_id: 'STuPAD123'
                   }
  }

  IPHONE_IPAD_DATA = {
      ipad: IPAD_DATA[:ipad],
      iphone: IPHONE_DATA[:iphone],
  }

  ANDROID_URL_TAG = '<meta property="al:android:url" content="andy://docs1" />'
  ANDROID_APP_TAG = '<meta property="al:android:app_name" content="Stu Andy App" />'
  ANDROID_STORE_TAG = '<meta property="al:android:package" content="stujo.android" />'

  ANDROID_DATA = {android:
                      {
                          url: 'andy://docs1',
                          app_name: 'Stu Andy App',
                          package: 'stujo.android'
                      }
  }

  IOS_MULTI_DATA = {
      ios: [
          {
              url: 'applinks_v2://docs',
              app_name: 'App Links',
              app_store_id: '12345'
          },
          {
              url: 'applinks_v1://browse',
              app_name: 'App Links Old',
          }
      ]
  }

  IOS_VERSION_BREAKER = '<meta property="al:ios" />'


  WINDOWS_PHONE_MULTI_DATA = {
      windows_phone: [
          {
              url: 'applinks_v2://docs',
              app_name: 'App Links',
              app_id: '12345'
          },
          {
              url: 'applinks_v1://browse',
              app_name: 'App Links Old',
          }
      ]
  }

  WINDOWS_PHONE_VERSION_BREAKER = '<meta property="al:windows_phone" />'

  ALL_TARGETS = ["android", "windows", "iphone", "ios", "web"]

  it 'should respond to applinks' do
    expect(helper).to respond_to :applinks
  end
  context 'without configuration' do
    it 'should do nothing with no arguments' do
      expect(helper.applinks()).to eq ""
    end

    def all_targets_except *ex
      ALL_TARGETS.select { |v| !ex.include? v }
    end

    context 'ios only' do
      let(:full_ios) { helper.applinks(IOS_DATA) }

      it 'should not render any of the other meta tags' do
        expect(full_ios).to_not include *all_targets_except("ios")
      end

      it 'should render all the ios meta tags' do
        expect(full_ios).to include(IOS_URL_TAG, IOS_APP_TAG, IOS_STORE_TAG)
      end

      let(:part_ios_url) do
        helper.applinks({ios: {:url => IOS_DATA[:ios][:url]}})
      end

      it 'should only render the ios url meta tags' do
        expect(part_ios_url).to include IOS_URL_TAG
      end
      it 'should only render the ios url meta tags' do
        expect(part_ios_url).to_not include(IOS_APP_TAG, IOS_STORE_TAG)
      end
      it 'should not render any of the other meta tags' do
        expect(part_ios_url).to_not(
            include *all_targets_except("ios")
        )
      end
    end

    context 'iphone only' do

      let(:full_iphone) { helper.applinks(IPHONE_DATA) }

      it 'should not render any of the other meta tags' do
        expect(full_iphone).to_not include *all_targets_except("iphone")
      end

      it 'should render all the iphone meta tags' do
        expect(full_iphone).to include(IPHONE_URL_TAG, IPHONE_APP_TAG, IPHONE_STORE_TAG)
      end

      let(:part_iphone_url) do
        helper.applinks({iphone: {:url => IPHONE_DATA[:iphone][:url]}})
      end

      it 'should only render the iphone url meta tags' do
        expect(part_iphone_url).to include IPHONE_URL_TAG
      end
      it 'should only render the iphone url meta tags' do
        expect(part_iphone_url).to_not include(IPHONE_APP_TAG, IPHONE_STORE_TAG)
      end
      it 'should not render any of the other meta tags' do
        expect(part_iphone_url).to_not(
            include *all_targets_except("iphone")
        )
      end
    end


    context 'ipad only' do

      let(:full_ipad) { helper.applinks(IPAD_DATA) }

      it 'should not render any of the other meta tags' do
        expect(full_ipad).to_not include *all_targets_except("ipad")
      end

      it 'should render all the ipad meta tags' do
        expect(full_ipad).to include(IPAD_URL_TAG, IPAD_APP_TAG, IPAD_STORE_TAG)
      end

      let(:part_ipad_url) do
        helper.applinks({ipad: {:url => IPAD_DATA[:ipad][:url]}})
      end

      it 'should only render the ipad url meta tags' do
        expect(part_ipad_url).to include IPAD_URL_TAG
      end
      it 'should only render the ipad url meta tags' do
        expect(part_ipad_url).to_not include(IPAD_APP_TAG, IPAD_STORE_TAG)
      end
      it 'should not render any of the other meta tags' do
        expect(part_ipad_url).to_not(
            include *all_targets_except("ipad")
        )
      end
    end

    context 'iphone and ipad only' do
      let(:iphone_ipad) { helper.applinks(IPHONE_IPAD_DATA) }

      it 'should not render any of the other meta tags' do
        expect(iphone_ipad).to_not include *all_targets_except("ipad", "iphone")
      end

      it 'should render all the iphone and ipad meta tags' do
        expect(iphone_ipad).to include(IPHONE_URL_TAG, IPHONE_APP_TAG, IPHONE_STORE_TAG,
                                       IPAD_URL_TAG, IPAD_APP_TAG, IPAD_STORE_TAG)
      end
    end

    context 'android only' do
      let(:full_android) { helper.applinks(ANDROID_DATA) }

      it 'should not render any of the other meta tags' do
        expect(full_android).to_not include *all_targets_except("android")
      end

      it 'should render all the android meta tags' do
        expect(full_android).to include(ANDROID_URL_TAG, ANDROID_APP_TAG, ANDROID_STORE_TAG)
      end

      let(:part_android_url) do
        helper.applinks({android: {:url => ANDROID_DATA[:android][:url]}})
      end

      let(:part_android_package) do
        helper.applinks({android: {:package => ANDROID_DATA[:android][:package]}})
      end

      it 'should only render the iphone url meta tags' do
        expect(part_android_package).to include ANDROID_STORE_TAG
      end


      it 'should not render the android url meta tags because package not supplied' do
        expect(part_android_url).to eq ""
      end
      it 'should only render the android url meta tags' do
        expect(part_android_package).to_not include(ANDROID_APP_TAG, ANDROID_URL_TAG)
      end
      it 'should not render any of the other meta tags' do
        expect(part_android_package).to_not(
            include *all_targets_except("android")
        )
      end
    end

    context 'has multiple ios versions' do
      let(:multi_version_meta_array) do
        helper.applinks(IOS_MULTI_DATA).to_s.split("\n")
      end

      it 'should start with the version breaker' do
        expect(multi_version_meta_array[0]).to eq IOS_VERSION_BREAKER
      end

      it 'should be newest url' do
        expect(multi_version_meta_array[1]).to eq '<meta property="al:ios:url" content="applinks_v2://docs" />'
      end

      it 'should be newest app_store_id' do
        expect(multi_version_meta_array[2]).to eq '<meta property="al:ios:app_store_id" content="12345" />'
      end

      it 'should be newest app_name' do
        expect(multi_version_meta_array[3]).to eq '<meta property="al:ios:app_name" content="App Links" />'
      end

      it 'should end block with the version breaker' do
        expect(multi_version_meta_array[4]).to eq IOS_VERSION_BREAKER
      end

      it 'should be older url' do
        expect(multi_version_meta_array[5]).to eq '<meta property="al:ios:url" content="applinks_v1://browse" />'
      end

      it 'should be older app_name' do
        expect(multi_version_meta_array[6]).to eq '<meta property="al:ios:app_name" content="App Links Old" />'
      end
      it 'should be 7 lines' do
        expect(multi_version_meta_array.length).to eq 7
      end
    end

    context 'has multiple windows_phone versions' do
      let(:multi_version_meta_array) do
        helper.applinks(WINDOWS_PHONE_MULTI_DATA).to_s.split("\n")
      end

      it 'should start with the version breaker' do
        expect(multi_version_meta_array[0]).to eq WINDOWS_PHONE_VERSION_BREAKER
      end

      it 'should be newest url' do
        expect(multi_version_meta_array[1]).to eq '<meta property="al:windows_phone:url" content="applinks_v2://docs" />'
      end

      it 'should be newest app_id' do
        expect(multi_version_meta_array[2]).to eq '<meta property="al:windows_phone:app_id" content="12345" />'
      end

      it 'should be newest app_name' do
        expect(multi_version_meta_array[3]).to eq '<meta property="al:windows_phone:app_name" content="App Links" />'
      end

      it 'should end block with the version breaker' do
        expect(multi_version_meta_array[4]).to eq WINDOWS_PHONE_VERSION_BREAKER
      end

      it 'should be older url' do
        expect(multi_version_meta_array[5]).to eq '<meta property="al:windows_phone:url" content="applinks_v1://browse" />'
      end

      it 'should be older app_name' do
        expect(multi_version_meta_array[6]).to eq '<meta property="al:windows_phone:app_name" content="App Links Old" />'
      end
      it 'should be 7 lines' do
        expect(multi_version_meta_array.length).to eq 7
      end
    end

    context 'web url forwarding' do


      WEB_FALLBACK_DATA = {web:
                               {
                                   url: 'http://applinks.org/documentation'
                               }
      }

      WEB_NOT_FALLBACK_DATA = {web:
                                   {
                                       should_fallback: false
                                   }
      }

      WEB_NOT_FB_OVERRIDE = {
          web:{
              url: WEB_FALLBACK_DATA[:web][:url],
              should_fallback: WEB_NOT_FALLBACK_DATA[:web][:should_fallback],
          }


      }

      context 'web fallback' do
        let(:web_fallback) do
          helper.applinks(WEB_FALLBACK_DATA).to_s.split("\n")
        end
        it 'should contain the forwarding url' do
          expect(web_fallback[0]).to eq '<meta property="al:web:url" content="http://applinks.org/documentation" />'
        end
        it 'should have one line' do
          expect(web_fallback.length).to eq 1
        end
      end
      context 'no web fallback' do
        let(:web_not_fallback) do
          helper.applinks(WEB_NOT_FALLBACK_DATA).to_s.split("\n")
        end

        it 'should contain should_fallback false' do
          expect(web_not_fallback[0]).to eq '<meta property="al:web:should_fallback" content="false" />'
        end
        it 'should have one line' do
          expect(web_not_fallback.length).to eq 1
        end
      end
      context 'no web fallback (override url)' do
        let(:web_not_fallback_override) do
          helper.applinks(WEB_NOT_FB_OVERRIDE).to_s.split("\n")
        end

        it 'should contain should_fallback false' do
          expect(web_not_fallback_override[0]).to eq '<meta property="al:web:should_fallback" content="false" />'
        end
        it 'should have one line' do
          expect(web_not_fallback_override.length).to eq 1
        end
      end
    end
  end
end
