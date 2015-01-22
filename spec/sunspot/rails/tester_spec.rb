require 'spec_helper'

module Sunspot
  module Rails
    describe Tester do
      let(:tester) { described_class }

      describe '.start_original_sunspot_session' do
        let(:server) { double('sunspot_rails_server') }
        let(:pid) { 5555 }

        before do
          Sunspot::Rails::Server.should_receive(:new).and_return(server)
          tester.should_receive(:fork).and_return(pid)
          tester.should_receive(:kill_at_exit)
          tester.should_receive(:give_feedback)
        end

        after { tester.clear }

        it 'sets the "server" attribute' do
          tester.start_original_sunspot_session
          tester.server.should eq(server)
        end

        it 'sets the "started" attribute' do
          tester.start_original_sunspot_session
          tester.started.should be_an_instance_of(Time)
        end

        it 'sets the "pid" attribute' do
          tester.start_original_sunspot_session
          tester.pid.should eq(pid)
        end
      end

      describe '.started?' do
        context 'given the "server" attribute is nil' do
          specify { tester.should_not be_started }
        end

        context 'given the "server" attribute is not nil' do
          before { tester.server = :not_nil }
          specify { tester.should be_started }
        end
      end

      describe '.starting' do
        let(:uri) { double('uri') }

        before do
          tester.should_receive(:sleep)
          tester.should_receive(:uri).and_return(uri)
          URI.should_receive(:parse).with(uri)
        end

        context 'given the "uri" is available' do
          it 'returns false' do
            Net::HTTP.should_receive(:get_response)
            tester.starting.should be false
          end
        end

        context 'given the "uri" is not available' do
          it 'returns true' do
            Net::HTTP.should_receive(:get_response).and_raise(Errno::ECONNREFUSED)
            tester.starting.should be true
          end
        end
      end

      describe '.seconds' do
        context 'given the "started" attribute is set to 5 seconds ago' do
          before { tester.started = Time.now - 5 }
          specify { tester.seconds.should eq('5.00') }
        end
      end

      describe '.uri' do
        context 'given hostname|port|path is set to: localhost|5555|/solr' do
          let(:configuration) do
            double 'configuration', :hostname => 'localhost',
                                    :port => 5555,
                                    :path => '/solr'
          end

          before { tester.stub(:configuration).and_return(configuration) }
          specify { tester.uri.should eq('http://localhost:5555/solr') }
        end
      end

      describe '.clear' do
        context 'given the "server" attribute is not nil' do
          before { tester.server = :not_nil }

          it 'sets it to nil' do
            tester.server.should eq(:not_nil)
            tester.clear
            tester.server.should be_nil
          end
        end
      end

    end
  end
end
