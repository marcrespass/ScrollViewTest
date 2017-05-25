# ScrollViewTest

Test of Nib-less vs Nib with auto-layout

Typical UITextField inside a UIScrollView in order to move text field out of the way of the keyboard

If loaded from a xib, all works as expected. If built programmatically, app crashes with unresolved constraints.
Used https://eject.herokuapp.com to extract the xib and build programmatically. Have compared the constraints in LLDB and both seem to be the same. Have looked through the xib and all the constraints are the same. I cannot figure out why it crashes without a xib but works with the xib.
The only thing that is different is that the Xib has an autoresize mask set but the xibless does not

* WITH XIB
`(lldb) po self.scrollView!`
`<UIScrollView: 0x7fc34f051600; frame = (0 187; 280 341); clipsToBounds = YES; autoresize = RM+BM; gestureRecognizers = <NSArray: 0x6080002423d0>; layer = <CALayer: 0x608000235460>; contentOffset: {0, 0}; contentSize: {300, 341}>`

* WITHOUT
`(lldb) po self.scrollView`
`<UIScrollView: 0x7fff06839400; frame = (0 187; 280 341); clipsToBounds = YES; gestureRecognizers = <NSArray: 0x600000242790>; layer = <CALayer: 0x600000226900>; contentOffset: {0, 0}; contentSize: {300, 341}>`
