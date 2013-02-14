require 'spec_helper'
require 'hydrant/dropbox'
require 'hydrant/batch_ingest'

describe Hydrant::Batch do
  # Get rid of all .processing stubs left over in case something was aborted
  # mid test
  before :all do
    # TODO : Locate all .processing files and delete them from the spec
    #        dropbox    
  end

  before :each do
    Hydrant::DropboxService = Hydrant::Dropbox.new 'spec/fixtures/dropbox'
  end

  after :each do
    # this file is created to signify that the file has been processed
    # we need to remove it so can re-run the tests
    processed_status_file = 'spec/fixtures/dropbox/example_batch_ingest/batch_manifest.xlsx.processed'
    File.delete( processed_status_file ) if File.exists?( processed_status_file)
    
    # this is a test environment, we don't want to kick off
    # generation jobs if possible
    MasterFile.any_instance.stub(:save).and_return( true )
   end

  it 'creates an ingest batch object' do
    Hydrant::Batch.ingest
    IngestBatch.count.should == 1
  end

  it 'does not create an ingest batch object when there are zero packages' do
    Hydrant::DropboxService.stub(:find_new_packages).and_return []
    Hydrant::Batch.ingest
    IngestBatch.count.should == 0
  end
end