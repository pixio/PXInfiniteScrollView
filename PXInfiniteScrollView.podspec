Pod::Spec.new do |s|
  s.name             = "PXInfiniteScrollView"
  s.version          = "0.1.2"
  s.summary          = "Pages. It loops.  It's infinite."
  s.description      = <<-DESC
                       It has uses. Just don't scroll too fast.
                       DESC
  s.homepage         = "https://github.com/pixio/PXInfiniteScrollView"
  s.license          = 'MIT'
  s.author           = { "Kevin Wong" => "kwong@pixio.com" }
  s.source = {
   :git => "https://github.com/pixio/PXInfiniteScrollView.git",
   :tag => s.version.to_s
  }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/PXInfiniteScrollView.{h,m}'

  s.public_header_files = 'Pod/Classes/PXInfiniteScrollView.h'
  s.frameworks = 'UIKit'
end
