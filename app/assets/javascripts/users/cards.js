$(document).on('turbolinks:load', function() {
  console.log("It works on each visit!");

  $(function() {
    // 自身の公開鍵をセット(テスト公開鍵)
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
      //エラーメッセージ消去
      removeErrorMessage();
      // トークンを取得
      Payjp.createToken(card, function(s, response) {
        //トークン取得エラー
        if (response.error) {
          if (response.error.code ==  "invalid_number") {
            buildInvalidNumberErrorMessage();
          }
          else if (response.error.code == "invalid_cvc") {
            buildInvalidCVCErrorMessage();
          }
          else if (response.error.code == "expired_card") {
            buildInvalidExpiredErrorMessage();
          }
          else if(response.error.code !== null)
          {
            debugger;
            buildInvalidCardErrorMessage();
          }
        }
        else {
          var token = response.id;
          // payjp.jsから送られたカードトークンをformに追加して送信
          form.append($('<input type="hidden" name="payjpToken" />').val(token));
          form.get(0).submit();
        }
        //ボタン有効化
        form.find('.card-container__form__field__button').prop('disabled', false);
      });
    });
  });

  //エラーメッセージ消去
  function removeErrorMessage() {
    $(".card-error_message").remove();
  }

  //エラーメッセージ表示
  function buildInvalidNumberErrorMessage() {
    var html = `<p id="card_number__error_message" class="card-error_message">
                  カード番号が正しくありません
                </p>`
    // 作成したHTMLをカード番号入力の下に追加する
    $("#card_number").after(html);
  }

  //エラーメッセージ表示
  function buildInvalidCVCErrorMessage() {
    var html = `<p id="card_cvc__error_message" class="card-error_message">
                  セキュリティコードが正しくありません
                </p>`
    // 作成したHTMLをカード番号入力の下に追加する
    $("#card_form").after(html);
  }

  function buildInvalidExpiredErrorMessage() {
    var html = `<p id="card_expired__error_message" class="card-error_message">
                  有効期限が切れています
                </p>`
    // 作成したHTMLをカード番号入力の下に追加する
    $(".card-container__form__field__date").after(html);
  }

  

  //エラーメッセージ表示
  function buildInvalidCardErrorMessage() {
    var html = `<p class="card-error_message">
                  このカードはご利用になれません。
                </p>`
    // 作成したHTMLをカード番号入力の下に追加する
    $("#card_form").prepend(html);
  }

});