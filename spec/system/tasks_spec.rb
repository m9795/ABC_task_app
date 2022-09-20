require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      # ユーザーAを作成しておく
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      # 作成者がユーザーAであるタスクを作成しておく
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)
    end
  
    context 'ユーザーAがログインしているとき' do
      before do
        # ユーザーAでログインする
        visit login_path # ログイン画面へアクセス
        fill_in 'メールアドレス', with: 'a@example.com' # メールアドレスを入力
        fill_in 'パスワード', with: 'password' # パスワードを入力
        click_button 'ログインする' # ログインボタンを押す
      end
      
      it 'ユーザーAが作成したタスクが表示される' do
        # 作成済みタスクの名称が画面上に表示されていることを確認
        expect(page).to have_content '最初のタスク'
      end
    end
    
    context 'ユーザーBがログインしているとき' do
      before do
        # ユーザーBを作成
        FactoryBot.create(:user, name: 'ユーザーB', email: 'b@examplel.com')
        # ユーザーBでログインする
        visit login_path
        fill_in 'メールアドレス', with: 'b@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end
      
      it 'ユーザーAが作成したタスクが表示されない' do
        # ユーザーAが作成したタスクの名称が画面上に表示されていないことを確認
        expect(page).to have_no_content '最初のタスク'
      end
    end
    
  end
end