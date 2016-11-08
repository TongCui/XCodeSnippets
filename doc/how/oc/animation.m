// How to push with crossfade animation type

// for push

CATransition *transition = [CATransition animation];
transition.duration = 0.3;
transition.type = kCATransitionFade;
//transition.subtype = kCATransitionFromTop;

[self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
[self.navigationController pushViewController:ViewControllerYouWantToPush animated:NO];


//for pop

CATransition *transition = [CATransition animation];
transition.duration = 0.3;
transition.type = kCATransitionFade;
//transition.subtype = kCATransitionFromTop;

[self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
[self.navigationController popViewControllerAnimated:NO];
