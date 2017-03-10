//: Playground - noun: a place where people can play

import UIKit

let tracks = ["a", "b","c","d","e"]

//Algo should wrap the tracks so that if we select "d" we get


["d","e","a","b","c"]

var playlist = [String]()
var priorTracks = [String]()
let selectedTrack = "d"

for track in tracks{
    if track == selectedTrack||playlist.count > 0{
    playlist.append(track)
    print(playlist)
    } else{
    priorTracks.append(track)
    }
    print(playlist + priorTracks)
}

//or
let index = tracks.index(where: {return $0 == selectedTrack})
// in a real situation use an if let to unwrap the optional
let prefixArray = tracks.prefix(index!)
let suffixArray = tracks.suffix(index! - 1)
print(suffixArray + prefixArray)
