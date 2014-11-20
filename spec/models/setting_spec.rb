require 'rails_helper'

RSpec.describe Setting, :type => :model do
  describe '.get' do
    it 'should get the setting by its name' do
      setting = Setting.new(name: 'testsetting')
      setting.save
      expect(Setting.get('testsetting')).to eq(setting)
    end
  end

  describe '.render' do
    context 'with boolean set to true' do
      it 'should render the contents' do
        setting = Setting.new(name: 'testsetting', boolean: true, content: 'content')
        setting.save
        expect(Setting.render('testsetting')).to eq('content')
      end
    end

    context 'with boolean set to false' do
      it 'should not render the contents' do
        setting = Setting.new(name: 'testsetting', boolean: false, content: 'content')
        setting.save
        expect(Setting.render('testsetting')).to eq('')
      end
    end
  end
end
