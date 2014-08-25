require 'spec_helper'

describe "ApplicationHelperWithDefaults" do

  WDEFAULTS_DEFAULTS = {
      ios: {
          app_store_id: 'STUJO123DEFAULT',
          app_name: 'Stu Test App DEFAULT'
      },
      iphone: {
          app_store_id: 'STuPHONE123DEFAULT',
          app_name: 'Stu iphone App DEFAULT'
      }
  }


  WDEFAULTS_IOS_URL_TAG = '<meta property="al:ios:url" content="xyz://docsoriginal" />'
  WDEFAULTS_IOS_APP_TAG = '<meta property="al:ios:app_name" content="Stu Test App OVERRIDE" />'
  WDEFAULTS_IOS_STORE_TAG = '<meta property="al:ios:app_store_id" content="STUJO123DEFAULT" />'
  WDEFAULTS_IOS_APP_DEFAULT_TAG = '<meta property="al:ios:app_name" content="Stu Test App DEFAULT" />'

  WDEFAULTS_IOS_DATA = {ios:
                            {
                                url: 'xyz://docsoriginal',
                                app_name: 'Stu Test App OVERRIDE',
                            }
  }

  WDEFAULTS_IPHONE_URL_TAG = '<meta property="al:iphone:url" content="ipxyz://docs" />'
  WDEFAULTS_IPHONE_APP_TAG = '<meta property="al:iphone:app_name" content="Stu iPhone App Override" />'
  WDEFAULTS_IPHONE_STORE_TAG = '<meta property="al:iphone:app_store_id" content="STuPHONE123OVR" />'
  WDEFAULTS_IPHONE_DEFAULT_APP_TAG = '<meta property="al:iphone:app_name" content="Stu iphone App DEFAULT" />'
  WDEFAULTS_IPHONE_DEFAULT_STORE_TAG = '<meta property="al:iphone:app_store_id" content="STuPHONE123DEFAULT" />'


  WDEFAULTS_IPHONE_DATA = {iphone:
                               {
                                   url: 'ipxyz://docs',
                                   app_name: 'Stu iPhone App Override',
                                   app_store_id: 'STuPHONE123OVR'
                               }
  }


  WDEFAULTS_IPAD_URL_TAG = '<meta property="al:ipad:url" content="ipadxyz://docs" />'
  WDEFAULTS_IPAD_APP_TAG = '<meta property="al:ipad:app_name" content="Stu iPad App" />'
  WDEFAULTS_IPAD_STORE_TAG = '<meta property="al:ipad:app_store_id" content="STuPAD123" />'

  WDEFAULTS_IPAD_DATA = {ipad:
                             {
                                 url: 'ipadxyz://docs',
                                 app_name: 'Stu iPad App',
                                 app_store_id: 'STuPAD123'
                             }
  }

  WDEFAULTS_IPHONE_IPAD_DATA = {
      ipad: WDEFAULTS_IPAD_DATA[:ipad],
      iphone: WDEFAULTS_IPHONE_DATA[:iphone],
  }

  WDEFAULTS_ANDROID_URL_TAG = '<meta property="al:android:url" content="andy://docs1" />'
  WDEFAULTS_ANDROID_APP_TAG = '<meta property="al:android:app_name" content="Stu Andy App" />'
  WDEFAULTS_ANDROID_STORE_TAG = '<meta property="al:android:package" content="stujo.android" />'

  WDEFAULTS_ANDROID_DATA = {android:
                                {
                                    url: 'andy://docs1',
                                    app_name: 'Stu Andy App',
                                    package: 'stujo.android'
                                }
  }

  WDEFAULTS_IOS_MULTI_DATA = {
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

  WDEFAULTS_IOS_VERSION_BREAKER = '<meta property="al:ios" />'


  WDEFAULTS_WINDOWS_PHONE_MULTI_DATA = {
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

  WDEFAULTS_WINDOWS_PHONE_VERSION_BREAKER = '<meta property="al:windows_phone" />'

  WDEFAULTS_ALL_TARGETS = ["android", "windows", "iphone", "ios", "web"]

  it 'should respond to applinks' do
    expect(helper).to respond_to :applinks
  end

  context 'without configuration' do
    before :each do
      Applinks::Config.config do |config|
        config.defaults = nil
      end
    end
    it 'should do nothing with no arguments' do
      expect(helper.applinks()).to eq ""
    end
  end

  context 'with default con' do

    after :each do
      Applinks::Config.config do |config|
        config.defaults = nil
      end
    end

    before :each do
      Applinks::Config.config do |config|
        config.defaults = WDEFAULTS_DEFAULTS
      end
    end


    def all_targets_except *ex
      WDEFAULTS_ALL_TARGETS.select { |v| !ex.include? v }
    end

    context 'ios only' do
      let(:full_ios) { helper.applinks(WDEFAULTS_IOS_DATA) }

      it 'should not render any of the other meta tags' do
        expect(full_ios).to_not include *all_targets_except("ios")
      end

      it 'should render all the ios meta tags' do
        expect(full_ios).to include(WDEFAULTS_IOS_URL_TAG, WDEFAULTS_IOS_APP_TAG, WDEFAULTS_IOS_STORE_TAG)
      end

      let(:part_ios_url) do
        helper.applinks({ios: {:url => WDEFAULTS_IOS_DATA[:ios][:url]}})
      end

      it 'should render the ios url meta tags and the defaults' do
        expect(part_ios_url).to include(WDEFAULTS_IOS_URL_TAG, WDEFAULTS_IOS_APP_DEFAULT_TAG, WDEFAULTS_IOS_STORE_TAG)
      end
      it 'should not render any of the other meta tags' do
        expect(part_ios_url).to_not(
            include *all_targets_except("ios")
        )
      end
    end

    context 'iphone only' do

      let(:full_iphone) { helper.applinks(WDEFAULTS_IPHONE_DATA) }

      it 'should not render any of the other meta tags' do
        expect(full_iphone).to_not include *all_targets_except("iphone")
      end

      it 'should render all the iphone meta tags' do
        expect(full_iphone).to include(WDEFAULTS_IPHONE_URL_TAG, WDEFAULTS_IPHONE_APP_TAG, WDEFAULTS_IPHONE_STORE_TAG)
      end

      let(:part_iphone_url) do
        helper.applinks({iphone: {:url => WDEFAULTS_IPHONE_DATA[:iphone][:url]}})
      end

      it 'should render the iphone url and app default meta tags' do
        expect(part_iphone_url).to include WDEFAULTS_IPHONE_URL_TAG, WDEFAULTS_IPHONE_DEFAULT_APP_TAG, WDEFAULTS_IPHONE_DEFAULT_STORE_TAG
      end

      it 'should not render any of the other meta tags' do
        expect(part_iphone_url).to_not(
            include *all_targets_except("iphone")
        )
      end
    end


    context 'ipad only' do

      let(:full_ipad) { helper.applinks(WDEFAULTS_IPAD_DATA) }

      it 'should not render any of the other meta tags' do
        expect(full_ipad).to_not include *all_targets_except("ipad")
      end

      it 'should render all the ipad meta tags' do
        expect(full_ipad).to include(WDEFAULTS_IPAD_URL_TAG, WDEFAULTS_IPAD_APP_TAG, WDEFAULTS_IPAD_STORE_TAG)
      end

      let(:part_ipad_url) do
        helper.applinks({ipad: {:url => WDEFAULTS_IPAD_DATA[:ipad][:url]}})
      end

      it 'should only render the ipad url meta tags' do
        expect(part_ipad_url).to include WDEFAULTS_IPAD_URL_TAG
      end

      it 'should only render the ipad url and no default meta tags' do
        expect(part_ipad_url.to_str.strip).to eq WDEFAULTS_IPAD_URL_TAG
      end

      it 'should not render any of the other meta tags' do
        expect(part_ipad_url).to_not(
            include *all_targets_except("ipad")
        )
      end
    end

    context 'iphone and ipad only' do
      let(:iphone_ipad) { helper.applinks(WDEFAULTS_IPHONE_IPAD_DATA) }

      it 'should not render any of the other meta tags' do
        expect(iphone_ipad).to_not include *all_targets_except("ipad", "iphone")
      end

      it 'should render all the iphone and ipad meta tags' do
        expect(iphone_ipad).to include(WDEFAULTS_IPHONE_URL_TAG, WDEFAULTS_IPHONE_APP_TAG, WDEFAULTS_IPHONE_STORE_TAG,
                                       WDEFAULTS_IPAD_URL_TAG, WDEFAULTS_IPAD_APP_TAG, WDEFAULTS_IPAD_STORE_TAG)
      end
    end

    context 'android only' do
      let(:full_android) { helper.applinks(WDEFAULTS_ANDROID_DATA) }

      it 'should not render any of the other meta tags' do
        expect(full_android).to_not include *all_targets_except("android")
      end

      it 'should render all the android meta tags' do
        expect(full_android).to include(WDEFAULTS_ANDROID_URL_TAG, WDEFAULTS_ANDROID_APP_TAG, WDEFAULTS_ANDROID_STORE_TAG)
      end

      let(:part_android_url) do
        helper.applinks({android: {:url => WDEFAULTS_ANDROID_DATA[:android][:url]}})
      end

      let(:part_android_package) do
        helper.applinks({android: {:package => WDEFAULTS_ANDROID_DATA[:android][:package]}})
      end

      it 'should only render the iphone url meta tags' do
        expect(part_android_package).to include WDEFAULTS_ANDROID_STORE_TAG
      end


      it 'should not render the android url meta tags because package not supplied' do
        expect(part_android_url).to eq ""
      end
      it 'should only render the android url meta tags' do
        expect(part_android_package).to_not include(WDEFAULTS_ANDROID_APP_TAG, WDEFAULTS_ANDROID_URL_TAG)
      end
      it 'should not render any of the other meta tags' do
        expect(part_android_package).to_not(
            include *all_targets_except("android")
        )
      end
    end

    context 'has multiple ios versions' do
      let(:multi_version_meta_array) do
        helper.applinks(WDEFAULTS_IOS_MULTI_DATA).to_s.split("\n")
      end

      it 'should start with the version breaker' do
        expect(multi_version_meta_array[0]).to eq WDEFAULTS_IOS_VERSION_BREAKER
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
        expect(multi_version_meta_array[4]).to eq WDEFAULTS_IOS_VERSION_BREAKER
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
        helper.applinks(WDEFAULTS_WINDOWS_PHONE_MULTI_DATA).to_s.split("\n")
      end

      it 'should start with the version breaker' do
        expect(multi_version_meta_array[0]).to eq WDEFAULTS_WINDOWS_PHONE_VERSION_BREAKER
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
        expect(multi_version_meta_array[4]).to eq WDEFAULTS_WINDOWS_PHONE_VERSION_BREAKER
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


      WDEFAULTS_WEB_FALLBACK_DATA = {web:
                                         {
                                             url: 'http://applinks.org/documentation'
                                         }
      }

      WDEFAULTS_WEB_NOT_FALLBACK_DATA = {web:
                                             {
                                                 should_fallback: false
                                             }
      }

      WDEFAULTS_WEB_NOT_FB_OVERRIDE = {
          web: {
              url: WDEFAULTS_WEB_FALLBACK_DATA[:web][:url],
              should_fallback: WDEFAULTS_WEB_NOT_FALLBACK_DATA[:web][:should_fallback],
          }


      }

      context 'web fallback' do
        let(:web_fallback) do
          helper.applinks(WDEFAULTS_WEB_FALLBACK_DATA).to_s.split("\n")
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
          helper.applinks(WDEFAULTS_WEB_NOT_FALLBACK_DATA).to_s.split("\n")
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
          helper.applinks(WDEFAULTS_WEB_NOT_FB_OVERRIDE).to_s.split("\n")
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
