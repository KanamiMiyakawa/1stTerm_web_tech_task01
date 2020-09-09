require 'webrick'
#WEBrick::HTTPServer.newでwebrickインスタンスを作成し、serverに代入
server = WEBrick::HTTPServer.new({
#DocumentRoot：このWebアプリケーションのドメインになる
#CGIInterpreter：このプログラムを実行（翻訳）できるプログラム（Rubyのこと）本体の居場所を指定
#Port：このWebアプリケーションの情報の出入り口を表す
#ドメイン・IPアドレス・ポートなどの設定がWebアプリケーションには必要であり、今回のプログラムでは使用するRubyの場所を指定する必要がある
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
#Webサーバを起動した状態で、（DocumentRootの値）/testというURLを送信すると、同じディレクトリ階層にあるtest.html.erbファイルを表示する
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'top.html.erb')
server.start
