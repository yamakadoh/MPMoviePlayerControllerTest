//
//  ViewController.swift
//  MPMoviePlayerControllerTest
//
//  Created by yamakadoh on 2/8/15.
//  Copyright (c) 2015 yamakadoh. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    let moviePlayer = MPMoviePlayerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL(string: "https://mtc.cdn.vine.co/r/videos/55E9B17281990629401697910784_1d8613ad683.3.1_jqxCCdF_bYEX05o4k7Pi24VMJbVJmPLJAZZR1LAtk9Xz_Qwf3G5m8c1ggKDdJAaW.mp4?versionId=6pLpbrMHhP2yPXDq.nboJfDbZjXQR3zA")
        moviePlayer.prepareToPlay()
        moviePlayer.movieSourceType = MPMovieSourceType.Streaming
        moviePlayer.contentURL = url    // contentURLは、movieSourceTypeプロパティより後に設定しないとなぜか落ちた http://stackoverflow.com/questions/12041260/an-avplayeritem-cannot-be-associated-with-more-than-one-instance-of-avplayer
        moviePlayer.controlStyle = MPMovieControlStyle./*Embedded*/None
        moviePlayer.scalingMode = MPMovieScalingMode.AspectFill
        moviePlayer.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.size.width, height: 240))
//        moviePlayer.view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
//        moviePlayer.view.autoresizesSubviews = true
        self.view.addSubview(moviePlayer.view)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "moviePlayerDidChangeState:", name: MPMoviePlayerPlaybackStateDidChangeNotification, object: moviePlayer)
        
        moviePlayer.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func moviePlayerDidChangeState(note: NSNotification) {
        let playbackState = self.moviePlayer.playbackState
        println("[moviePlayerDidChangeState]playbackState = \(playbackState.rawValue)")
        
        let isReplayAvailable = playbackState == .Stopped || playbackState == .Paused || playbackState == .Interrupted
        if isReplayAvailable {
            if note.object as MPMoviePlayerController == self.moviePlayer {
//                let reason = note.userInfo(objectForKey: MPMoviePlayerPlaybackDidFinishReasonUserInfoKey).integerValue
//                if reason == MPMovieFinishReasonPlaybackEnded {
//                    self.moviePlayer.play()
//                }
            }
        }
    }
}

