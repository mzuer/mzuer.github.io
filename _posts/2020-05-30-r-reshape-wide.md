---
layout: post
title: "R - <em>reshape()</em> - direction wide"
date: 2020-05-30
category: R
tags: R function data_frame
---

<em>reshape()</em> direction wide:




```
head(dt1)
                       hicds                  exprds intervalFCC  countFCC
8       Barutcu_MCF-10A_40kb        TCGAbrca_lum_bas   ]0.75, 1] 0.2510216
16        Barutcu_MCF-7_40kb        TCGAbrca_lum_bas   ]0.75, 1] 0.2701422
24     ENCSR079VIJ_G401_40kb      TCGAkich_norm_kich   ]0.75, 1] 0.2963400
32 ENCSR312KHQ_SK-MEL-5_40kb TCGAskcm_lowInf_highInf   ]0.75, 1] 0.2530488
40 ENCSR312KHQ_SK-MEL-5_40kb     TCGAskcm_wt_mutBRAF   ]0.75, 1] 0.2809263
48 ENCSR312KHQ_SK-MEL-5_40kb   TCGAskcm_wt_mutCTNNB1   ]0.75, 1] 0.3180987



mdt1 <-  reshape(dt1, idvar=c("hicds", "exprds"),direction = "wide", timevar="intervalFCC")
head(mdt1)
                       hicds                  exprds countFCC.]0.75, 1]
8       Barutcu_MCF-10A_40kb        TCGAbrca_lum_bas          0.2510216
16        Barutcu_MCF-7_40kb        TCGAbrca_lum_bas          0.2701422
24     ENCSR079VIJ_G401_40kb      TCGAkich_norm_kich          0.2963400
32 ENCSR312KHQ_SK-MEL-5_40kb TCGAskcm_lowInf_highInf          0.2530488
40 ENCSR312KHQ_SK-MEL-5_40kb     TCGAskcm_wt_mutBRAF          0.2809263
48 ENCSR312KHQ_SK-MEL-5_40kb   TCGAskcm_wt_mutCTNNB1          0.3180987


```


