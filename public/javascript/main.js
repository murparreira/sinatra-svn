$(function() {

  $('#check_all').change(function() {
    if ($(this).is(':checked')) {
      $('#div-files input[type=checkbox]').prop('checked', 'checked');
    } else {
      $('#div-files input[type=checkbox]').prop('checked', '');
    }
  });

  $('#submittrunk').click(function(e) {
    var checked = $('#div-files input[type=checkbox]:checked');
    var mensagem = $('#mensagem').val();
    if ($.trim(mensagem).length === 0) {
      alert('Informe a mensagem de commit!');
      e.preventDefault();
      return false;
    }
    if (checked.length === 0) {
      alert('Selecione pelo menos um arquivo para commitar!');
      e.preventDefault();
      return false;
    }
  });

  $('#submitproducao').click(function(e) {
    var checked = $('#div-files input[type=checkbox]:checked');
    var mensagem = $('#mensagem').val();
    var usuario = $('#usuario').val();
    if ($.trim(usuario).length === 0) {
      alert('Informe o usuário do commit!');
      e.preventDefault();
      return false;
    }
    if ($.trim(mensagem).length === 0) {
      alert('Informe a mensagem de commit!');
      e.preventDefault();
      return false;
    }
    if (checked.length === 0) {
      alert('Selecione pelo menos um arquivo para commitar!');
      e.preventDefault();
      return false;
    }
  });

});