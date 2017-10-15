---
layout: post
title: "Bash - <em>tar</em> unzip or extract only a given file from big archive"
date: 2017-10-15
category: bash
tags: [bash]
---

To extract and decompress only a file from a big archive:

```
tar -x contact_maps/HiCNorm_QQ/primary_cohort/AO.nor.chr1.qq.mat -zf all_data_contact_maps.tgz
```
