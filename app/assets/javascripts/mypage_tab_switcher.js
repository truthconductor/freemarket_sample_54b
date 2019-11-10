$(document).on('turbolinks:load', function() {
  // マイページトップ画面のタブをクリックで切り替える
  // 正規表現を使いマイページ以外で処理を行わせないようにする
  var re = new RegExp('/mypage$');
  if(!re.test(location.pathname)) {
    return;
  }

  // マイページ内のタブページ
  var notification_tab = document.getElementById('user-notification-tab');
  var notification_page = document.getElementById('user-notification-page');
  var todo_tab = document.getElementById('user-todo-tab');
  var todo_page = document.getElementById('user-todo-page');
  var in_transaction_tab = document.getElementById('user-in-transaction-tab');
  var in_transaction_page = document.getElementById('user-in-transaction-page');
  var past_transaction_tab = document.getElementById('user-past-transaction-tab');
  var past_transaction_page = document.getElementById('user-past-transaction-page');

  // お知らせタブクリック
  notification_tab.addEventListener("click", function() {
    // お知らせが非表示の時、お知らせ表示が有効になるようにCSSを切り替え
    if(notification_page.classList.contains('user-tabcontent__page--none'))
    {
      notification_tab.classList.add('user-tabcontent__tabbar__tab--active')
      notification_page.classList.remove('user-tabcontent__page--none');
      todo_tab.classList.remove('user-tabcontent__tabbar__tab--active')
      todo_page.classList.add('user-tabcontent__page--none');
    }
  }, false);

  // やることリストタブクリック
  todo_tab.addEventListener("click", function() {
    // やることリストが非表示の時、やることリスト表示が有効になるようにCSSを切り替え
    if(todo_page.classList.contains('user-tabcontent__page--none'))
    {
      todo_tab.classList.add('user-tabcontent__tabbar__tab--active')
      todo_page.classList.remove('user-tabcontent__page--none');
      notification_tab.classList.remove('user-tabcontent__tabbar__tab--active')
      notification_page.classList.add('user-tabcontent__page--none');
    }
  }, false);

  // 取引中タブクリック
  in_transaction_tab.addEventListener("click", function() {
    // 取引中タブが非表示の時、取引中表示が有効になるようにCSSを切り替え
    if(in_transaction_page.classList.contains('user-tabcontent__page--none'))
    {
      in_transaction_tab.classList.add('user-tabcontent__tabbar__tab--active')
      in_transaction_page.classList.remove('user-tabcontent__page--none');
      past_transaction_tab.classList.remove('user-tabcontent__tabbar__tab--active')
      past_transaction_page.classList.add('user-tabcontent__page--none');
    }
  }, false);

  // 過去の取引タブクリック
  past_transaction_tab.addEventListener("click", function() {
    // 過去の取引タブが非表示の時、過去の取引表示が有効になるようにCSSを切り替え
    if(past_transaction_page.classList.contains('user-tabcontent__page--none'))
    {
      past_transaction_tab.classList.add('user-tabcontent__tabbar__tab--active')
      past_transaction_page.classList.remove('user-tabcontent__page--none');
      in_transaction_tab.classList.remove('user-tabcontent__tabbar__tab--active')
      in_transaction_page.classList.add('user-tabcontent__page--none');
    }
  }, false);

});