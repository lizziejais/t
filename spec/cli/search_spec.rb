# encoding: utf-8
require 'helper'

describe T::CLI::Search do

  before do
    rcfile = RCFile.instance
    rcfile.path = fixture_path + "/.trc"
    @t = T::CLI.new
    Timecop.freeze(Time.local(2011, 11, 24, 16, 20, 0))
    @old_stderr = $stderr
    $stderr = StringIO.new
    @old_stdout = $stdout
    $stdout = StringIO.new
  end

  after do
    $stderr = @old_stderr
    $stdout = @old_stdout
  end

  describe "#all" do
    before do
      stub_request(:get, "https://search.twitter.com/search.json").
        with(:query => {:q => "twitter", :include_entities => "false", :rpp => "20"}).
        to_return(:body => fixture("search.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "should request the correct resource" do
      @t.search("all", "twitter")
      a_request(:get, "https://search.twitter.com/search.json").
        with(:query => {:q => "twitter", :include_entities => "false", :rpp => "20"}).
        should have_been_made
    end
    it "should have the correct output" do
      @t.search("all", "twitter")
      $stdout.string.should == <<-eos.gsub(/^/, ' ' * 6)
  killermelons: @KaiserKuo from not too far away your new twitter icon looks like Vader. (about 1 year ago)
  FelipeNoMore: RT @nicoMaiden: RT @golden254: Quien habra sido el habil en decirle al negro piñera que era cantante?/el mismo que le dijo a @copano que la lleva en twitter (about 1 year ago)
         Je_eF: é cada louco que tem nesse twitter que o vicio nao me deixa largar isso jamé (about 1 year ago)
 TriceyTrice2U: @Jae_Savage same name as twitter (about 1 year ago)
     eternity4: @enishi39 Its awesome huh? Its ALL Spn anime epicness!! I had a tough time getting twitter to put it up.xD (about 1 year ago)
       twittag: [Twitter*feed] 船井総研発！一番店の法則～実費型治療院（整骨院・接骨院）・サロン経営コンサルティングブログ～ http://bit.ly/cxoSGL (about 1 year ago)
       twittag: [Twitter*feed] ニフティクラウド、明日より「サーバーコピー」、「カスタマイズイメージ」、「オートスケール」、「基本監視・パフォーマンスチャート」を公開 | P2P today ダブルスラッシュ http://wslash.com/?p=2959 (about 1 year ago)
       twittag: [Twitter*feed] ニフティクラウド、明日より「サーバーコピー」、「カスタマイズイメージ」、「オートスケール」、「基本監視・パフォーマンスチャート」を公開 | P2P today ダブルスラッシュ http://bit.ly/aziQQo (about 1 year ago)
   ArcangelHak: Bueno pues me desconectó de twitter al tatto le falta todavía un rato y ya casi tengo sueño (about 1 year ago)
 recycledhumor: Just in case you are wondering, Weird Al (@alyankovic) has 1,862,789 followers on Twitter. Correction: 1,862,790 followers on Twitter. (about 1 year ago)
      junitaaa: Lama&quot; chat di twitter nih..hahaha RT @buntutbabi: Lo yg mulai juga,siiietRT @Junitaaa: Kelakuan @buntutbabi (cont) http://tl.gd/6m1dcv (about 1 year ago)
       twittag: [Twitter*feed] 『かちびと.net』 の人気エントリー - はてなブックマーク http://bit.ly/9Yx6xS (about 1 year ago)
      avexnews: @ICONIQ_NEWS opened!She gain attention by collaboration song「I'm lovin' you」wif EXILE・ATSUSHI.Get her newest info here! http://bit.ly/dymm8v (about 1 year ago)
   WildIvory92: RT @FiercePrinceJ: People on Twitter Gossip about other People, Hate others? This Is Twitter Nothing More, Nothing Less. (about 1 year ago)
       twittag: [Twitter*feed] Now Playing Friends - リニューアル式 : R49 http://bit.ly/bmlA5g (about 1 year ago)
      eos
    end
  end

  describe "#timeline" do
    it "should request the correct resource" do
      1.upto(16).each do |page|
        stub_get("/1/statuses/home_timeline.json").
          with(:query => {:count => "200", :page => "#{page}"}).
          to_return(:body => fixture("statuses.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      end
      @t.search("timeline", "twitter")
      1.upto(16).each do |page|
        a_get("/1/statuses/home_timeline.json").
          with(:query => {:count => "200", :page => "#{page}"}).
          should have_been_made
      end
    end
    it "should have the correct output" do
      1.upto(16).each do |page|
        stub_get("/1/statuses/home_timeline.json").
          with(:query => {:count => "200", :page => "#{page}"}).
          to_return(:body => fixture("statuses.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      end
      @t.search("timeline", "twitter")
      $stdout.string.should == <<-eos.gsub(/^/, ' ' * 6)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
      eos
    end
    context "Twitter is down" do
      it "should retry 3 times and then raise an error" do
        1.upto(15).each do |page|
          stub_get("/1/statuses/home_timeline.json").
            with(:query => {:count => "200", :page => "#{page}"}).
            to_return(:body => fixture("statuses.json"), :headers => {:content_type => "application/json; charset=utf-8"})
        end
        stub_get("/1/statuses/home_timeline.json").
          with(:query => {:count => "200", :page => "16"}).
          to_return(:status => 502)
        lambda do
          @t.search("timeline", "twitter")
        end.should raise_error("Twitter is down or being upgraded.")
        a_get("/1/statuses/home_timeline.json").
          with(:query => {:count => "200", :page => "16"}).
          should have_been_made.times(3)
      end
    end
  end

  describe "#user" do
    it "should request the correct resource" do
      1.upto(16).each do |page|
        stub_get("/1/statuses/user_timeline.json").
          with(:query => {:screen_name => "sferik", :count => "200", :page => "#{page}"}).
          to_return(:body => fixture("statuses.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      end
      @t.search("user", "sferik", "twitter")
      1.upto(16).each do |page|
        a_get("/1/statuses/user_timeline.json").
          with(:query => {:screen_name => "sferik", :count => "200", :page => "#{page}"}).
          should have_been_made
      end
    end
    it "should have the correct output" do
      1.upto(16).each do |page|
        stub_get("/1/statuses/user_timeline.json").
          with(:query => {:screen_name => "sferik", :count => "200", :page => "#{page}"}).
          to_return(:body => fixture("statuses.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      end
      @t.search("user", "sferik", "twitter")
      $stdout.string.should == <<-eos.gsub(/^/, ' ' * 6)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
        sferik: 140 Proof Provides A Piece Of The Twitter Advertising Puzzle http://t.co/R2cUSDe via @techcrunch (about 1 year ago)
        sferik: I know @SarahPalinUSA has a right to use Twitter, but should she? (over 1 year ago)
      eos
    end
    context "Twitter is down" do
      it "should retry 3 times and then raise an error" do
        1.upto(15).each do |page|
          stub_get("/1/statuses/user_timeline.json").
            with(:query => {:screen_name => "sferik", :count => "200", :page => "#{page}"}).
            to_return(:body => fixture("statuses.json"), :headers => {:content_type => "application/json; charset=utf-8"})
        end
        stub_get("/1/statuses/user_timeline.json").
          with(:query => {:screen_name => "sferik", :count => "200", :page => "16"}).
          to_return(:status => 502)
        lambda do
          @t.search("user", "sferik", "twitter")
        end.should raise_error("Twitter is down or being upgraded.")
        a_get("/1/statuses/user_timeline.json").
          with(:query => {:screen_name => "sferik", :count => "200", :page => "16"}).
          should have_been_made.times(3)
      end
    end
  end

end
