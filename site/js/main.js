var $ = require('jquery');

require('jquery.starscroll');
$('#starfield').starscroll(
    16,             // mode             int     "16-bit" rather than "8-bit"; looks nicer, supports color, etc.
    3,              // parallax         int     int: number of levels; max 10.
    20,             // density          int     number of stars.
    4,              // dimension        int     size of stars; max 20.
    4,              // smoothness       int     scroll smoothness speed; min 0, max 5.
    [255,255,255],  // color            int     rgb array [255,255,255]
    true,           // color variance   bool    subtle color variance enabled/disabled.
    false           // animate          bool    auto-scrolling starfield enabled/disabled.
);
