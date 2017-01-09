//---------------GLOBAL VARIABLES----------------//
fineness = 10;


//---------------MOON----------------//

module moonRaw(){
    moonTranslate = [0, 0, 4];
    translate(moonTranslate) difference(){
        sphere(r=6, $fn = fineness);
        craters();
    };
};

module craters(){
    translate([-5.5, 0, 2.5]) rotate([0, 20, 0]) scale([0.2, 1, 1])  sphere(r=2, $fn = fineness);
    //translate([-4, -3, 2]) sphere(r=2, $fn = fineness); 
    //translate([-3.5, 3, 0.8]) sphere(r=1.5, $fn = fineness);
    //translate([-3, 4, 2]) sphere(r=2, $fn = fineness);
    translate([0, 4, 4.2]) rotate([0, -50, 90]) scale([0.2, 1, 1]) sphere(r=1.5, $fn = fineness); 
    //translate([0, 6.5, 5]) sphere(r=2, $fn = fineness); 
    //translate([2, -4, 4.2]) sphere(r=2, $fn = fineness); 
    //translate([2.5, 6, 2.5]) sphere(r=2, $fn = fineness); 
    translate([5.6, 1, 1]) rotate([0, -10, 10]) scale([0.2, 1, 1]) sphere(r=2, $fn = fineness); 
    //translate([4.5, 4, 3.5]) sphere(r=2, $fn = fineness); 
};

module moonBase(){
    rotate_extrude(angle=90, convexity=10) translate([4.7, 0]) circle(1, $fn = 30);    
};

module baseSubtract(){
    translate([0, 0, -10]) cube(size = 20, center = true);
};

module moonWithBase(){
    moonRaw();
    moonBase();
};

module moon(){
    difference(){
       moonWithBase();
       baseSubtract(); 
    };
};

//---------------CRESCENT MOON----------------//

module outerCrescent(){
    rotate([90, -30, 0]) translate([0, 0, -2]) linear_extrude(height=4) circle(r=8, $fn=30);
};

module innerCrescent(){
    rotate([90, -30, 0]) translate([5, 0, -3]) linear_extrude(height=8) circle(r=7, $fn=30);
};

module crescentMoonRaw(){
    translate([0, 0, 7]) 
            difference(){
                outerCrescent();
                innerCrescent();
            };
};

module moonRounding(){
    difference(){
        crescentMoonRaw();
        union(){
            translate([-6, 4, 6]) rotate([90, -30, 0]) linear_extrude(height=8) circle(r=12, $fn=30);    
            translate([5.2, 4, 1.9]) rotate([90, -30, 0]) linear_extrude(height=8) circle(r=0.75, $fn=30);
            translate([5, 4, 1]) rotate([90, -30, 0]) linear_extrude(height=8) circle(r=0.75, $fn=30);    
        };
    };
};


module crescentMoon(){
    scale([0.6, 1.1, 0.6]) translate([-1.3, 0, 0]) rotate([0, 10, 0]) difference(){
        crescentMoonRaw();
        union(){
            scale([1.1, 1.1, 1.1]) moonRounding();
            translate([-7, 0, 12.4]) scale([1.1, 1.1, 1.1]) moonRounding();
        };
    };
};

//---------------FLUKE----------------//
//------FLUKE SEGMENTS-------//

module flukeDifference(){
    cutoff_1_Translate = [0.5, 2.5, 0];
    cutoff_1_Scale = [2, 1, 1];
    translate(cutoff_1_Translate) scale(cutoff_1_Scale) cube(4, center=true);
};

module flukeSeg1(){
    flukeTranslate = [1, 0, 0];
    flukeScale = [1, 1, 0.18];
    translate(flukeTranslate) scale(flukeScale) sphere(r=3, $fn = fineness);
};

module flukeSeg2_1(){
    flukeScale = [1, 1, 0.25];
    flukeTranslate = [0, -3, 0];
    translate(flukeTranslate) scale(flukeScale) sphere(r=2, $fn = fineness);
};

module flukeSeg2_2(){
    flukeScale = [1, 1, 0.25];
    flukeTranslate = [-1.5, -3, 0];
    translate(flukeTranslate) scale(flukeScale) sphere(r=2, $fn = fineness);
};

module flukeSeg3_1(){
    flukeScale = [1, 1, 0.33];
    flukeTranslate = [-1.5, -6, 0];
    translate(flukeTranslate) scale(flukeScale) sphere(r=1.5, $fn = fineness);
};

module flukeSeg3_2(){
    flukeScale = [1, 1, 0.33];
    flukeTranslate = [-2.5, -6, 0];
    translate(flukeTranslate) scale(flukeScale) sphere(r=1.5, $fn = fineness);
};

module flukeSeg4_1(){
    flukeScale = [1, 1, 0.5];
    flukeTranslate = [-2, -9, 0];
    translate(flukeTranslate) scale(flukeScale) sphere(r=1, $fn = fineness);
};

module flukeSeg4_2(){
    flukeScale = [1, 1, 0.5];
    flukeTranslate = [-2.5, -9, 0];
    translate(flukeTranslate) scale(flukeScale) sphere(r=1, $fn = fineness);
};

module flukeSeg5_1(){
    flukeScale = [1, 1, 1];
    flukeTranslate = [-2.5, -10.5, 0];
    translate(flukeTranslate) scale(flukeScale) sphere(r=0.5, $fn = fineness);
};

module flukeSeg5_2(){
    flukeScale = [1, 1, 1];
    flukeTranslate = [-3.5, -11, 0];
    translate(flukeTranslate) scale(flukeScale) sphere(r=0.5, $fn = fineness);
};

//------FLUKE HULLS-------//

module flukeHull1_2(){
    flukeSeg1();
    flukeSeg2_1();
    flukeSeg2_2();
};

module flukeHull2_3(){
    flukeSeg2_1();
    flukeSeg2_2();
    flukeSeg3_1();
    flukeSeg3_2();
};

module flukeHull3_4(){
    flukeSeg3_1();
    flukeSeg3_2();
    flukeSeg4_1();
    flukeSeg4_2();
};

module flukeHull4_5(){
    flukeSeg4_1();
    flukeSeg4_2();
    flukeSeg5_1();
    flukeSeg5_2();
};

//------FLUKE BUILD-------//

module flukeHalfRaw(){
    hull() flukeHull1_2();
    hull() flukeHull2_3();
    hull() flukeHull3_4();
    hull() flukeHull4_5();
};

module flukeHalf(){
    scale([1, 1, 2]) difference(){
        flukeHalfRaw();
        flukeDifference();
    };
};

module fluke(){
    flukeTranslate = [-34.5, 0, 10];
    flukeRotate = [0, 70, 0];
    translate(flukeTranslate) rotate(flukeRotate) union(){
        flukeHalf();
        scale([1, -1, 1]) flukeHalf();
    };
};

module flukeForSmallWhale(){
    flukeTranslate = [-34.5, 0, 10];
    flukeRotate = [0, 70, 0];
    flukeScale = [1.5, 0.9, 2];
    translate(flukeTranslate) rotate(flukeRotate) scale(flukeScale) union(){
        flukeHalf();
        scale([1, -1, 1]) flukeHalf();
    };
};

//---------------FLIPPERS----------------//
//------FLIPPER SEGMENTS-------//

module flipperDifference(){
    cutoff_1_Translate = [0.5, 2.5, 0];
    cutoff_1_Scale = [2, 1, 1];
    translate(cutoff_1_Translate) scale(cutoff_1_Scale) cube(4, center=true);
};

module flipperSeg1(){
    flipperTranslate = [1, 0, 0];
    flipperScale = [1, 1, 0.25];
    translate(flipperTranslate) scale(flipperScale) sphere(r=1, $fn = fineness);
};

module flipperSeg2_1(){
    flipperScale = [1, 1, 0.25];
    flipperTranslate = [0, -3, 0];
    translate(flipperTranslate) scale(flipperScale) sphere(r=1.5, $fn = fineness);
};

module flipperSeg2_2(){
    flipperScale = [1, 1, 0.25];
    flipperTranslate = [-1.5, -3, 0];
    translate(flipperTranslate) scale(flipperScale) sphere(r=1.5, $fn = fineness);
};

module flipperSeg2_3(){
    flipperScale = [1, 1, 0.25];
    flipperTranslate = [-1.5, -4.5, 0];
    translate(flipperTranslate) scale(flipperScale) sphere(r=1, $fn = fineness);
};

module flipperSeg3_1(){
    flipperScale = [1, 1, 0.25];
    flipperTranslate = [-1, -6, 0];
    translate(flipperTranslate) scale(flipperScale) sphere(r=1.5, $fn = fineness);
};

module flipperSeg3_2(){
    flipperScale = [1, 1, 0.25];
    flipperTranslate = [-1.5, -6, 0];
    translate(flipperTranslate) scale(flipperScale) sphere(r=1.5, $fn = fineness);
};

module flipperSeg3_3(){
    flipperScale = [1, 1, 0.25];
    flipperTranslate = [-1.5, -7.5, 0];
    translate(flipperTranslate) scale(flipperScale) sphere(r=1, $fn = fineness);
};

module flipperSeg4_1(){
    flipperScale = [1, 1, 0.25];
    flipperTranslate = [-2, -9, 0];
    translate(flipperTranslate) scale(flipperScale) sphere(r=1, $fn = fineness);
};

module flipperSeg4_2(){
    flipperScale = [1, 1, 0.25];
    flipperTranslate = [-2.5, -9, 0];
    translate(flipperTranslate) scale(flipperScale) sphere(r=1, $fn = fineness);
};

module flipperSeg4_3(){
    flipperScale = [1, 1, 0.5];
    flipperTranslate = [-3, -10.25, 0];
    translate(flipperTranslate) scale(flipperScale) sphere(r=0.5, $fn = fineness);
};

module flipperSeg5_1(){
    flipperScale = [1, 1, 0.5];
    flipperTranslate = [-2.5, -10.5, 0];
    translate(flipperTranslate) scale(flipperScale) sphere(r=0.5, $fn = fineness);
};

module flipperSeg5_2(){
    flipperScale = [1, 1, 0.5];
    flipperTranslate = [-3.5, -11, 0];
    translate(flipperTranslate) scale(flipperScale) sphere(r=0.5, $fn = fineness);
};

//------FLIPPER HULLS-------//

module flipperHull1_2(){
    flipperSeg1();
    flipperSeg2_1();
    flipperSeg2_2();
    flipperSeg2_3();
};

module flipperHull2_3(){
    flipperSeg2_1();
    //flipperSeg2_2();
    flipperSeg2_3();
    flipperSeg3_1();
    flipperSeg3_2();
    flipperSeg3_3();
};

module flipperHull3_4(){
    flipperSeg3_1();
    //flipperSeg3_2();
    flipperSeg3_3();
    flipperSeg4_1();
    flipperSeg4_2();
    flipperSeg4_3();
};

module flipperHull4_5(){
    flipperSeg4_1();
    //flipperSeg4_2();
    flipperSeg4_3();
    flipperSeg5_1();
    flipperSeg5_2();
};

//------FLIPPER BUILD-------//

module flipperHalfRaw(){
    hull() flipperHull1_2();
    hull() flipperHull2_3();
    hull() flipperHull3_4();
    hull() flipperHull4_5();
};

module flipperHalf(){
    flipperScale = [1, 1, 4];
    flipperTranslate = [-12.5, -2.5, -5];
    flipperRotate = [30, 0, 0];

    translate(flipperTranslate) rotate(flipperRotate) scale(flipperScale) difference(){
        flipperHalfRaw();
        flipperDifference();
    };
};

module flippers(){
    union(){
        flipperHalf();
        scale([1, -1, 1]) flipperHalf();
    };
};

module MainflipperHalf(){
    flipperScale = [1, 1, 4];
    flipperTranslate = [-12.5, -2.5, -5];
    flipperRotate = [30, 0, -40];

    translate(flipperTranslate) rotate(flipperRotate) scale(flipperScale) difference(){
        flipperHalfRaw();
        flipperDifference();
    };
};

module Mainflippers(){
    union(){
        MainflipperHalf();
        scale([1, -1, 1]) MainflipperHalf();
    };
};

//---------------DORSAL FIN----------------//

//---------------EYES----------------//

module eye(){
    eyeTranslate = [-5.5, 2.7, -3];
    eyeScale = [1, 0.5, 1];
    pupilTranslate = [-4.7, 3.1, -3];
    pupilScale = [1, 0.5, 1];
    pupilRotate = [0, 0, -20];
    translate(eyeTranslate) scale(eyeScale) sphere(r=1.2, $fn = fineness);
    translate(pupilTranslate) rotate(pupilRotate) scale(pupilScale) sphere(r=0.4, $fn = fineness);
};

module eyes(){
    eyeScale = [1, -1, 1];
    eye();
    scale(eyeScale) eye();
};

//---------------BODY----------------//
//-----BODY SEGMENTS-----//

module bodySeg1(){
    bodyScale = [1, 1.3, 2];
    bodyTranslate = [-10, 0, -1.8];
    translate(bodyTranslate) scale(bodyScale) sphere(r=2, $fn = fineness);
};

module bodySeg2(){
    bodyScale = [1, 1, 2];
    bodyTranslate = [-14, 0, -2];
    translate(bodyTranslate) scale(bodyScale) sphere(r=2, $fn = fineness);
};

module bodySeg3(){
    bodyScale = [0.7, 0.7, 1.5];
    bodyTranslate = [-18, 0, -2];
    translate(bodyTranslate) scale(bodyScale) sphere(r=2, $fn = fineness);
};

module bodySeg4(){
    bodyScale = [0.7, 0.3, 1];
    bodyTranslate = [-28, 0, 1];
    translate(bodyTranslate) scale(bodyScale) sphere(r=2, $fn = fineness);
};

module bodySeg5(){
    bodyScale = [0.7, 0.3, 0.5];
    bodyTranslate = [-32, 0, 4];
    translate(bodyTranslate) scale(bodyScale) sphere(r=2, $fn = fineness);
};

module bodySeg6(){
    bodyScale = [0.2, 0.3, 0.5];
    bodyTranslate = [-34, 0, 8];
    translate(bodyTranslate) scale(bodyScale) sphere(r=2, $fn = fineness);
};

//-----BODY BASES-----//

module bodySeg1_2Base(){
    baseScale = [2, 0.75, 0.75];
    baseTranslate = [-4, 0, -4];
    translate(baseTranslate) scale(baseScale) sphere(r=4,  $fn = fineness);
    
    baseScale2 = [2, 0.75, 0.4];
    baseTranslate2 = [-10, 0, -5.5];
    baseRotate2 = [0, 5, 0];
    translate(baseTranslate2) rotate(baseRotate2) scale(baseScale2) sphere(r=4,  $fn = fineness);
};

module bodySeg2_3Base(){    
    baseScale2 = [2, 0.75, 0.4];
    baseTranslate2 = [-10, 0, -5.5];
    baseRotate2 = [0, 5, 0];
    translate(baseTranslate2) rotate(baseRotate2) scale(baseScale2) sphere(r=4,  $fn = fineness);

    baseScale3 = [1.6, 0.5, 0.4];
    baseTranslate3 = [-16, 0, -4.5];
    baseRotate3 = [0, 10, 0];
    translate(baseTranslate3) rotate(baseRotate3) scale(baseScale3) sphere(r=4,  $fn = fineness);
};

module bodySeg3_4Base(){    
    baseScale2 = [2, 0.75, 0.4];
    baseTranslate2 = [-10, 0, -5.5];
    baseRotate2 = [0, 5, 0];
    translate(baseTranslate2) rotate(baseRotate2) scale(baseScale2) sphere(r=4,  $fn = fineness);

    baseScale4 = [1.6, 0.5, 0.4];
    baseTranslate4 = [-19, 0, -4];
    baseRotate4 = [0, 10, 0];
    translate(baseTranslate4) rotate(baseRotate4) scale(baseScale4) sphere(r=4,  $fn = fineness);
    
    baseScale4_2 = [1, 0.3, 0.2];
    baseTranslate4_2 = [-26.5, 0, -1.5];
    baseRotate4_2 = [0, 30, 0];
    translate(baseTranslate4_2) rotate(baseRotate4_2) scale(baseScale4_2) sphere(r=4,  $fn = fineness);
};

module bodySeg4_5Base(){    
    baseScale4_2 = [1, 0.3, 0.2];
    baseTranslate4_2 = [-26.5, 0, -1.5];
    baseRotate4_2 = [0, 30, 0];
    translate(baseTranslate4_2) rotate(baseRotate4_2) scale(baseScale4_2) sphere(r=4,  $fn = fineness);

    baseScale5 = [0.8, 0.2, 0.2];
    baseTranslate5 = [-31, 0, 2];
    baseRotate5 = [0, 50, 0];
    translate(baseTranslate5) rotate(baseRotate5) scale(baseScale5) sphere(r=4,  $fn = fineness);
};

module bodySeg5_6Base(){    
    baseScale5 = [0.8, 0.2, 0.2];
    baseTranslate5 = [-31, 0, 2];
    baseRotate5 = [0, 50, 0];
    translate(baseTranslate5) rotate(baseRotate5) scale(baseScale5) sphere(r=4,  $fn = fineness);
    
    baseScale6 = [0.8, 0.2, 0.2];
    baseTranslate6 = [-33, 0, 5];
    baseRotate6 = [0, 75, 0];
    translate(baseTranslate6) rotate(baseRotate6) scale(baseScale6) sphere(r=4,  $fn = fineness);
};

//-----BODY HULLS-----//

module bodySeg1_2Hull(){
    bodySeg1();
    bodySeg2();
    bodySeg1_2Base();
};

module bodySeg2_3Hull(){
    bodySeg2();
    bodySeg3();
    bodySeg2_3Base();
};

module bodySeg3_4Hull(){
    bodySeg3();
    bodySeg4();
    bodySeg3_4Base();
};

module bodySeg4_5Hull(){
    bodySeg4();
    bodySeg5();
    bodySeg4_5Base();
};

module bodySeg5_6Hull(){
    bodySeg5();
    bodySeg6();
    bodySeg5_6Base();
};


//---------------MAIN BODY----------------//
//-----BODY SEGMENTS-----//

module MainbodySeg1(){
    bodyScale = [1, 1.3, 2];
    bodyTranslate = [-10, 0, -1.8];
    translate(bodyTranslate) scale(bodyScale) sphere(r=2, $fn = fineness);
};

module MainbodySeg2(){
    bodyScale = [1, 1, 2];
    bodyTranslate = [-14, 0, -2];
    translate(bodyTranslate) scale(bodyScale) sphere(r=2, $fn = fineness);
};

module MainbodySeg3(){
    bodyScale = [0.7, 0.7, 1.5];
    bodyTranslate = [-18, 0, -3];
    translate(bodyTranslate) scale(bodyScale) sphere(r=2, $fn = fineness);
};

module MainbodySeg4(){
    bodyScale = [0.7, 0.3, 1];
    bodyTranslate = [-28, 0, -9];
    translate(bodyTranslate) scale(bodyScale) sphere(r=2, $fn = fineness);
};

module MainbodySeg5(){
    bodyScale = [0.7, 0.3, 0.5];
    bodyTranslate = [-31, 0, -14];
    translate(bodyTranslate) scale(bodyScale) sphere(r=2, $fn = fineness);
};

module MainbodySeg6(){
    bodyScale = [0.2, 0.3, 0.5];
    bodyTranslate = [-31.5, 0, -19];
    translate(bodyTranslate) scale(bodyScale) sphere(r=2, $fn = fineness);
};

//-----BODY BASES-----//

module MainbodySeg1_2Base(){
    baseScale = [2, 0.75, 0.75];
    baseTranslate = [-4, 0, -4];
    translate(baseTranslate) scale(baseScale) sphere(r=4,  $fn = fineness);
    
    baseScale2 = [2, 0.75, 0.4];
    baseTranslate2 = [-10, 0, -5.5];
    baseRotate2 = [0, -5, 0];
    translate(baseTranslate2) rotate(baseRotate2) scale(baseScale2) sphere(r=4,  $fn = fineness);
};

module MainbodySeg2_3Base(){    
    baseScale2 = [2, 0.75, 0.4];
    baseTranslate2 = [-10, 0, -5.5];
    baseRotate2 = [0, -5, 0];
    translate(baseTranslate2) rotate(baseRotate2) scale(baseScale2) sphere(r=4,  $fn = fineness);

    baseScale3 = [1.6, 0.5, 0.4];
    baseTranslate3 = [-16, 0, -6.5];
    baseRotate3 = [0, -10, 0];
    translate(baseTranslate3) rotate(baseRotate3) scale(baseScale3) sphere(r=4,  $fn = fineness);
};

module MainbodySeg3_4Base(){    
    baseScale3 = [1.6, 0.5, 0.4];
    baseTranslate3 = [-16, 0, -6.5];
    baseRotate3 = [0, -10, 0];
    translate(baseTranslate3) rotate(baseRotate3) scale(baseScale3) sphere(r=4,  $fn = fineness);

    baseScale4 = [1.6, 0.5, 0.4];
    baseTranslate4 = [-19, 0, -7];
    baseRotate4 = [0, -20, 0];
    translate(baseTranslate4) rotate(baseRotate4) scale(baseScale4) sphere(r=4,  $fn = fineness);
    
    baseScale4_2 = [1, 0.3, 0.2];
    baseTranslate4_2 = [-26.5, 0, -11];
    baseRotate4_2 = [0, -50, 0];
    translate(baseTranslate4_2) rotate(baseRotate4_2) scale(baseScale4_2) sphere(r=4,  $fn = fineness);
};

module MainbodySeg4_5Base(){    
    baseScale4_2 = [1, 0.3, 0.2];
    baseTranslate4_2 = [-26.5, 0, -11];
    baseRotate4_2 = [0, -50, 0];
    translate(baseTranslate4_2) rotate(baseRotate4_2) scale(baseScale4_2) sphere(r=4,  $fn = fineness);

    baseScale5 = [0.8, 0.2, 0.2];
    baseTranslate5 = [-29, 0, -15];
    baseRotate5 = [0, -70, 0];
    translate(baseTranslate5) rotate(baseRotate5) scale(baseScale5) sphere(r=4,  $fn = fineness);
};

module MainbodySeg5_6Base(){    
    baseScale5 = [0.8, 0.2, 0.2];
    baseTranslate5 = [-29, 0, -15];
    baseRotate5 = [0, -70, 0];
    translate(baseTranslate5) rotate(baseRotate5) scale(baseScale5) sphere(r=4,  $fn = fineness);
    
    baseScale6 = [0.8, 0.2, 0.2];
    baseTranslate6 = [-30, 0, -18];
    baseRotate6 = [0, -80, 0];
    translate(baseTranslate6) rotate(baseRotate6) scale(baseScale6) sphere(r=4,  $fn = fineness);
};

//-----BODY HULLS-----//

module MainbodySeg1_2Hull(){
    MainbodySeg1();
    MainbodySeg2();
    MainbodySeg1_2Base();
};

module MainbodySeg2_3Hull(){
    MainbodySeg2();
    MainbodySeg3();
    MainbodySeg2_3Base();
};

module MainbodySeg3_4Hull(){
    MainbodySeg3();
    MainbodySeg4();
    MainbodySeg3_4Base();
};

module MainbodySeg4_5Hull(){
    MainbodySeg4();
    MainbodySeg5();
    MainbodySeg4_5Base();
};

module MainbodySeg5_6Hull(){
    MainbodySeg5();
    MainbodySeg6();
    MainbodySeg5_6Base();
};


//---------------HEAD----------------//

module bodyHeadHull(){
    bodySeg1();
    headScale = [1, 0.75, 0.75];
    headBaseScale = [2, 0.75, 0.75];
    headBaseTranslate = [-4, 0, -4];
    scale(headScale) sphere(r = 4, $fn = fineness);
    translate(headBaseTranslate) scale(headBaseScale) sphere(r=4,  $fn = fineness);
}

module headWithEyes(){
    whaleHeadScale = [1, 1.2, 1];
    scale(whaleHeadScale) union(){
        hull() bodyHeadHull();
        eyes();
        hull() bodySeg1_2Hull();
        hull() bodySeg2_3Hull();
        hull() bodySeg3_4Hull();
        hull() bodySeg4_5Hull();
        hull() bodySeg5_6Hull();
    };
};

module headWithTongue(){
    headWithEyes();
    //tongue();
};

//---------------MAINHEAD----------------//

module MainbodyHeadHull(){
    MainbodySeg1();
    headScale = [1, 0.75, 0.75];
    headBaseScale = [2, 0.75, 0.75];
    headBaseTranslate = [-4, 0, -4];
    scale(headScale) sphere(r = 4, $fn = fineness);
    translate(headBaseTranslate) scale(headBaseScale) sphere(r=4,  $fn = fineness);
}

module MainheadWithEyes(){
    whaleHeadScale = [1, 1.2, 1];
    scale(whaleHeadScale) union(){
        hull() MainbodyHeadHull();
        eyes();
        hull() MainbodySeg1_2Hull();
        hull() MainbodySeg2_3Hull();
        hull() MainbodySeg3_4Hull();
        hull() MainbodySeg4_5Hull();
        hull() MainbodySeg5_6Hull();
    };
};

module mouth(){
    mouthPoints = [[0, 1],[0, -2], [-8, 0]];
    mouthRotate = [];
    mouthTranslateBeforeRotation = [0, 0, -4];
    mouthTranslate = [4, 0, -4];
    translate(mouthTranslate) rotate([90, 0, 0]) translate(mouthTranslateBeforeRotation) linear_extrude(height=8) polygon(points=mouthPoints);
};

module MainheadMinusMouth(){
    whaleHeadScale = [1, 1.2, 1];
    scale(whaleHeadScale) difference(){
        MainheadWithEyes();
        //mouth();
    };
};

module headMinusMouth(){
    whaleHeadScale = [1, 1.2, 1];
    scale(whaleHeadScale) difference(){
        headWithEyes();
        //mouth();
    };
};

module tongue(){
    tongueScale = [3, 0.75, 0.25];
    tongueTranslate = [-6.5, 0, -3.2];
    tongueRotate = [0, 15, 0];
    translate(tongueTranslate) rotate(tongueRotate) scale(tongueScale) sphere(r=3,  $fn = fineness);
};

//---------------FLUKE----------------//
//------FLUKE SEGMENTS-------//

module MainflukeDifference(){
    cutoff_1_Translate = [0.5, 2.5, 0];
    cutoff_1_Scale = [2, 1, 1];
    translate(cutoff_1_Translate) scale(cutoff_1_Scale) cube(4, center=true);
};

module MainflukeSeg1(){
    flukeTranslate = [1, 0, 0];
    flukeScale = [1, 1, 0.18];
    translate(flukeTranslate) scale(flukeScale) sphere(r=3, $fn = fineness);
};

module MainflukeSeg2_1(){
    flukeScale = [1, 1, 0.25];
    flukeTranslate = [0, -3, 0];
    translate(flukeTranslate) scale(flukeScale) sphere(r=2, $fn = fineness);
};

module MainflukeSeg2_2(){
    flukeScale = [1, 1, 0.25];
    flukeTranslate = [-1.5, -3, 0];
    translate(flukeTranslate) scale(flukeScale) sphere(r=2, $fn = fineness);
};

module MainflukeSeg3_1(){
    flukeScale = [1, 1, 0.33];
    flukeTranslate = [-1.5, -6, 0];
    translate(flukeTranslate) scale(flukeScale) sphere(r=1.5, $fn = fineness);
};

module MainflukeSeg3_2(){
    flukeScale = [1, 1, 0.33];
    flukeTranslate = [-2.5, -6, 0];
    translate(flukeTranslate) scale(flukeScale) sphere(r=1.5, $fn = fineness);
};

module MainflukeSeg4_1(){
    flukeScale = [1, 1, 0.5];
    flukeTranslate = [-2, -9, 0];
    translate(flukeTranslate) scale(flukeScale) sphere(r=1, $fn = fineness);
};

module MainflukeSeg4_2(){
    flukeScale = [1, 1, 0.5];
    flukeTranslate = [-2.5, -9, 0];
    translate(flukeTranslate) scale(flukeScale) sphere(r=1, $fn = fineness);
};

module MainflukeSeg5_1(){
    flukeScale = [1, 1, 1];
    flukeTranslate = [-2.5, -10.5, 0];
    translate(flukeTranslate) scale(flukeScale) sphere(r=0.5, $fn = fineness);
};

module MainflukeSeg5_2(){
    flukeScale = [1, 1, 1];
    flukeTranslate = [-3.5, -11, 0];
    translate(flukeTranslate) scale(flukeScale) sphere(r=0.5, $fn = fineness);
};

//------FLUKE HULLS-------//

module MainflukeHull1_2(){
    MainflukeSeg1();
    MainflukeSeg2_1();
    MainflukeSeg2_2();
};

module MainflukeHull2_3(){
    MainflukeSeg2_1();
    MainflukeSeg2_2();
    MainflukeSeg3_1();
    MainflukeSeg3_2();
};

module MainflukeHull3_4(){
    MainflukeSeg3_1();
    MainflukeSeg3_2();
    MainflukeSeg4_1();
    MainflukeSeg4_2();
};

module MainflukeHull4_5(){
    MainflukeSeg4_1();
    MainflukeSeg4_2();
    MainflukeSeg5_1();
    MainflukeSeg5_2();
};

//------FLUKE BUILD-------//

module MainflukeHalfRaw(){
    hull() MainflukeHull1_2();
    hull() MainflukeHull2_3();
    hull() MainflukeHull3_4();
    hull() MainflukeHull4_5();
};

module MainflukeHalf(){
    scale([1, 1, 2]) difference(){
        MainflukeHalfRaw();
        MainflukeDifference();
    };
};

module Mainfluke(){
    flukeTranslate = [-31.25, 0, -23.5];
    flukeRotate = [0, 90, 0];
    flukeScale = [1, 1, -1];
    translate(flukeTranslate) scale(flukeScale) rotate(flukeRotate) union(){
        MainflukeHalf();
        scale([1, -1, 1]) MainflukeHalf();
    };
};


//---------------BASE------------------//
module baseWithSlots(){
    whaleTranslate_1 = [9, 7, 6.8]; 
    whaleTranslate_2 = [9, -7, 6.8]; 
    //translate([6, -5, 2]) rotate([0, 0, 90]) scale([0.1, 0.1, 0.1]) text("MOON WHALE");
    difference(){
        linear_extrude(height=2) square (20, center=true);
        union(){
            translate(whaleTranslate_1) smallWhaleWithPeg();
            translate(whaleTranslate_2) smallWhaleWithPeg();
        };
    };
};

module baseCube(){
    translate([2, 0, 0.5]) linear_extrude(height=1.5) square(17, center=true);
};    
module baseRounding(){
    translate([-1, 0, -0.1]) scale([1.1, 1.1, 1.1]) difference(){
            baseCube();
            union(){
                translate([9.75, 9, 1.25]) rotate([90, -30, 0]) linear_extrude(height=18) circle(r=0.8, $fn=30);   
               translate([-1.8, 0, -0.1]) scale([1.1, 1.1, 1.1]) baseCube(); 
               translate([0, 0, -0.8]) scale([1.1, 1.1, 1.1]) baseCube(); 

            };
        };
};

module base(){
        difference(){
            baseCube();
            union(){
                baseRounding();
                translate([2, -2, 0]) rotate([0, 0, 90]) baseRounding();
                translate([4, 0, 0]) rotate([0, 0, 180]) baseRounding();
                translate([2, 2, 0]) rotate([0, 0, -90]) baseRounding();

            };
        };
};

//---------------FINAL CONSTRUCTION----------------//
//-------WHALE------//
module whale(){
    union(){
        headWithTongue();
        fluke();
        flippers();
    };
};

module Mainwhale(){
    union(){
        MainheadWithEyes();
        Mainfluke();
        Mainflippers();
    };
};

module smallWhale(){
    whaleScale = [0.25, 0.25, 0.25];
    whaleRotate = [0, -45, 0];
    rotate(whaleRotate) scale(whaleScale) union(){
        headWithTongue();
        flukeForSmallWhale();
        flippers();
    };
};

module whalePeg(){
    linear_extrude(height=3) square(1, center=true);
};

module whaleWithPeg(){
    primaryWhaleTranslate = [9, 0, 20];
    primaryWhaleScale = [0.6, 0.6, 0.6];
    translate(primaryWhaleTranslate) scale(primaryWhaleScale) whale();
    translate([-3.5, 0, 15.3]) whalePeg();
};

module whaleWithHole(){
    primaryWhaleTranslate = [9, 0, 20];
    primaryWhaleScale = [0.6, 0.6, 0.6];
    difference(){
        translate(primaryWhaleTranslate) scale(primaryWhaleScale) whale();
        translate([-3.5, 0, 15.3]) whalePeg();
    };
};

module primaryWhale(){
    primaryWhaleScale = [0.6, 0.6, 0.6];
    scale(primaryWhaleScale) whale();
};


//-------SMALL WHALES------//

module smallWhalePeg(){
   linear_extrude(height=1.5) square(0.3, center=true);
};

module smallWhaleWithPeg(){
    whaleScale = [0.25, 0.25, 0.25];
    whaleRotate = [0, -45, 0];
    rotate(whaleRotate) scale(whaleScale) whale();
    translate([-4.75, 0, -6.5]) smallWhalePeg();
};


module smallWhaleWithHole(){
    whaleScale = [0.25, 0.25, 0.25];
    whaleRotate = [0, -45, 0];
    difference(){
        rotate(whaleRotate) scale(whaleScale) whale();
        translate([-4.75, 0, -6.5]) smallWhalePeg();  
    };
};

module smallWhalePositioned(){
    whaleScale = [0.25, 0.25, 0.25];
    whaleRotate = [0, -45, 0];
    rotate(whaleRotate) scale(whaleScale) whale();
};

//------MOON-----//

module crescentMoonWithSlot(){
    moonTranslate = [-2, 0, 2.5];
    difference(){
        translate(moonTranslate) crescentMoon();
        whaleWithPeg();
    };
}

module baseAndCrescent(){
    translate([0, 0, 2]) crescentMoon();
    base();
};

module buildDemo(){
    whaleTranslate_1 = [0, 0, 3];
    whaleTranslate_2 = [9, 7, 10.5]; 
    whaleTranslate_3 = [9, -7, 10.5]; 
    translate(whaleTranslate_1) whaleWithPeg();
    baseAndCrescent();
   
    translate(whaleTranslate_2) smallWhaleWithPeg();
    translate(whaleTranslate_3) smallWhaleWithPeg();    
};


//------ORIENTED FOR PRINTING------//


module completeBuild(){
    whaleTranslate_1 = [6, 0, 14];
    MainwhaleScale = [0.35, 0.35, 0.35];
    whaleTranslate_2 = [9, 2.9, 6.5]; 
    whaleRotate_2 = [0, 0, -15];
    whaleTranslate_3 = [9, -2.9, 6.5]; 
    whaleRotate_3 = [0, 0, 15];
    translate(whaleTranslate_1) scale(MainwhaleScale) Mainwhale();
    baseAndCrescent();
    translate(whaleTranslate_2) rotate(whaleRotate_2) smallWhale();
    translate(whaleTranslate_3) rotate(whaleRotate_3) smallWhale();    
};

module completeBase(){
    whaleTranslate_2 = [9, 6, 6.5]; 
    whaleTranslate_3 = [9, -6, 6.5]; 
    baseAndCrescentMinusWhale();
    translate(whaleTranslate_2) smallWhalePositioned();
    translate(whaleTranslate_3) smallWhalePositioned();    
};


module smallWhaleWithHoleForPrint(){
    rotate([0, 90, 0]) smallWhaleWithHole();
};

module whaleWithHoleForPrint(){
    translate([0, 0, 11.5]) rotate([0, 70, 0]) translate([0, 0, -20]) whaleWithHole();
};

module whalePegForPrint(){
    scale([0.95, 0.95, 0.95]) whalePeg();
};

module smallWhalePegForPrint(){
    scale([0.95, 0.95, 0.85]) smallWhalePeg();
};


module flukeWithPegForPrint(){
    
    flukeRotate = [0, 90, 0];
    rotate(flukeRotate) difference(){
        union(){
            whaleScale = [0.25, 0.25, 0.25];
            whaleRotate = [0, -45, 0];
            rotate(whaleRotate) scale(whaleScale) whale();
            translate([-4.75, 0, -6.1]) scale([0.8, 0.8, 0.8]) smallWhalePeg();
        };
        union(){
            translate([0, 0, -2]) cube(8, center=true);
        };
    };
};

module smallWhaleWithPegForPrint(){
    whaleScale = [0.25, 0.25, 0.25];
    whaleRotate = [0, -45, 0];
    rotate(whaleRotate) scale(whaleScale) whale();
    translate([-4.75, 0, -6.1]) scale([0.8, 0.8, 0.8]) smallWhalePeg();
};

module baseAndCrescentMinusWhale(){
    difference(){
        baseAndCrescent();
        primaryWhaleForImprint();
    };
};

module primaryWhaleForImprint(){
    primaryWhaleTranslate = [7, 0, 21];
    imprintScale = [1.15, 1.15, 1.15];
    translate(primaryWhaleTranslate) scale(imprintScale) primaryWhale();
};

module primaryWhaleForDemo(){
    primaryWhaleTranslate = [10, 0, 21];
    translate(primaryWhaleTranslate) primaryWhale();
};

module primaryWhaleForPrint(){
    translate([0, 0, 10]) rotate([0, 70, 0]) translate([0, 0, -21]) primaryWhale();
};


//-----------FOR TESTING-----------//

module baseSlotTest(){
    difference(){  
        baseWithSlots();
        union(){
            translate([0, 10, 0]) cube(30, center=true);
            translate([0, -24, 0]) cube(30, center=true);
            translate([-14, 0, 0]) cube(30, center=true);
            translate([21.5, 0, 0]) cube(30, center=true);           
        };
    };
};



//-----------CONSTRUCTION ZONE---------//
printScale = [3, 3, 3];
testScale = [1,1,1];

//whale();
//scale(printScale) smallWhalePegForPrint();
//scale(printScale) smallWhaleWithHoleForPrint();
//scale(printScale) flukeWithPegForPrint();
//scale(printScale) smallWhaleWithPegForPrint();
//scale(printScale) smallWhaleWithPeg();
//scale(printScale) baseWithSlots();
//scale(printScale) baseSlotTest();
//scale(printScale) baseAndCrescentMinusWhale();  
//scale(printScale) primaryWhaleForPrint();
//scale(printScale) primaryWhaleForImprint();
//scale(printScale) completeBase();
//scale(printScale) primaryWhaleForDemo();
//scale(printScale) primaryWhale();  



//-------------------FOR SHOW----------------------//
//----Full build
completeBuild();

//----Whale
//whale();

//----Sections (for hull demo, search for "flukehalfraw()"
//fluke();

//flippers();






