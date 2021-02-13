---
layout: post
title: "Diagrams with <em>mermaid</em>"
date: 2021-02-13
category: visualization
tags: plot visualization html
---

Some examples of mermaid diagrams:
* class diagrams
* mermaid_classDiagrams.html
mermaid_entityRelationshipDiagrams.html
mermaid_flowcharts.html
mermaid_ganttDiagrams.html
mermaid_otherExamples.html
mermaid_pieCharts.html
mermaid_sequenceDiagrams.html
mermaid_simpleDiagrams.html
mermaid_stateDiagrams.html
mermaid_userJourney.html


<html>
  <body>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script>mermaid.initialize({startOnLoad:true});</script>
    
<a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_pieCharts.html">Pie charts</a>

    <div class="mermaid">
pie title NETFLIX
         "Time spent looking for movie" : 90
         "Time spent watching it" : 10
    </div>
</body>
</html>
