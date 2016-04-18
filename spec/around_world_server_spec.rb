require_relative '../xml_parser'

describe AroundWorldServer do
  before do
    @app = AroundWorldServer.new
    @app.start
  end

  it 'test something' do
    
  end

  after do
    @app.stop
  end
end
