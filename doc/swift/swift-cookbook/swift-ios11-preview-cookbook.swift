/*
Chapter 1. Snapshot Testing
[Facebook snapshot test case](https://github.com/facebook/ios-snapshot-test-case)
*/

//  Podfile
platform :ios, '10.0'

target 'SnapshotTesting' do
  use_frameworks!

  target 'SnapshotTestingTests' do
    inherit! :search_paths
    use_frameworks!
    pod 'FBSnapshotTestCase'
  end

end

/*
Add two keys and values to your environment variables, as shown in Figure 1-3). One key is is IMAGE_DIFF_DIR and has a value of $(SOURCE_ROOT)/$(PROJECT_NAME)Tests/FailureDiffs. The other key is FB_REFERENCE_IMAGE_DIR and has a value of $(SOURCE_ROOT)/$(PROJECT_NAME)Tests/ReferenceImages.

*/



