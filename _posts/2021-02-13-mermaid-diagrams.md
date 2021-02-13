---
layout: post
title: "Diagrams with <em>mermaid</em>"
date: 2021-02-13
category: visualization
tags: plot visualization html
---



Some examples of mermaid diagrams:
* <a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_simpleDiagrams.html">Simple diagrams</a>
* <a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_classDiagrams.html">Class diagrams</a>
* <a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_entityRelationshipDiagrams.html">Entity relationships diagrams</a>
* <a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_sequenceDiagrams.html">Sequence diagrams</a>
* <a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_stateDiagrams.html">State diagrams</a>
* <a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_ganttDiagrams.html">Gantt diagrams</a>
* <a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_flowcharts.html">Flow charts</a>
* <a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_pieCharts.html">Pie charts</a>
* <a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_userJourney.html">User journey</a>
* <a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_otherExamples.html">Other examples</a>


<html>
  <body>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script>mermaid.initialize({startOnLoad:true});</script>
    
<a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_simpleDiagrams.html">Simple diagrams</a>

    <div class="mermaid">
      graph TD
      A[Client] --> B[Load Balancer]
      B --> C[Server1]
      B --> D[Server2]
    </div>


</body>
</html>


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
