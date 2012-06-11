      it "only adds file that exist" do
        bundle.add("spec/assets/bundles/base/does_not_exist.js")
        bundle.files.should == []
      end