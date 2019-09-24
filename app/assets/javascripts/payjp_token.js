$(document).on('turbolinks:load', function() {
  $(function() {
    // 自身の公開鍵をセット(現時点ではテスト公開鍵)
    Payjp.setPublicKey('pk_test_8674f42029f2ad36e1e4a30c');
    // formを取得し追加ボタン処理でpayjpの非同期通信
    var form = $("#card_form");
    form.on("submit", function(e) {
      e.preventDefault();
      var formData = new FormData(this);
      // カード情報作成
      var card = {
        number: form.find("#card_number").val(),
        cvc: form.find('#card_cvc').val(),
        exp_month: form.find('#card_month').val(),
        exp_year: "20" + form.find('#card_year').val()
      };
      debugger;
      // トークンを取得
      Payjp.createToken(card, function(s, response) {
        //トークン取得エラー
        if (response.error) {
          //Todo エラーメッセージをページ上に出す
        }
        else {
          var token = response.id;
          // payjp.jsから送られたカードトークンをformに追加して送信
          form.append($('<p>' + token +  '</p>'));
          form.append($('<input type="hidden" name="payjpToken" />').val(token));
          // form.get(0).submit();
        }
        //ボタン有効化
        form.find('.card-container__form__field--btn').prop('disabled', false);
      });
    });
  });
});