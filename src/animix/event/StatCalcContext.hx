package animix.event;

import animix.entity.Ani;
import animix.ds.EStat;

typedef StatCalcContext = {
    var side :Bool;
    var subject :Ani;
    var type :EStat;
    var value :Int;
};