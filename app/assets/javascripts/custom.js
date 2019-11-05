// アクティブなヘッダーリンクに下線をつける
// 現在のURLを取得
var loc = location.href;
// 現在のURLのroot_url以下を取得
var file = loc.substring(loc.lastIndexOf("/")+1,loc.length);
// 現在のURLリンクを持つaタグの親要素(liタグ)にactiveクラスを追加(設定以下のdropdownは除外)
$('.header-link').children('a[href$="'+file+'"]').parent().addClass('active');
