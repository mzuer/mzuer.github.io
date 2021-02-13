---
layout: post
title: "Diagrams with <em>mermaid</em>"
date: 2021-02-13
category: visualization
tags: plot visualization html
---


See: <a href="https://mermaid-js.github.io">https://mermaid-js.github.io</a>

Mermaid lets you represent diagrams using text and code. This simplifies maintaining complex diagrams. It is a Javascript based diagramming and charting tool that renders Markdown-inspired text definitions to create and modify diagrams dynamically. The main purpose of Mermaid is to help Documentation catch up with Development.


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
* <a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_gitGraph.html">Git graph</a>
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
    
 <a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_classDiagrams.html">Class diagrams</a>

    <div class="mermaid">
classDiagram
    class BankAccount
    BankAccount : +String owner
    BankAccount : +Bigdecimal balance
    BankAccount : +deposit(amount)
    BankAccount : +withdrawl(amount)

    </div>

</body>
</html>

<html>
  <body>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script>mermaid.initialize({startOnLoad:true});</script>
    
 <a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_entityRelationshipDiagrams.html">Entity relationships diagrams</a>

    <div class="mermaid">
erDiagram
    CUSTOMER ||--o{ ORDER : places
    ORDER ||--|{ LINE-ITEM : contains
    CUSTOMER }|..|{ DELIVERY-ADDRESS : uses
    </div>

</body>
</html>


<html>
  <body>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script>mermaid.initialize({startOnLoad:true});</script>
    
<a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_sequenceDiagrams.html">Sequence diagrams</a>

    <div class="mermaid">
sequenceDiagram
    Alice->>+John: Hello John, how are you?
    John-->>-Alice: Great!
    </div>
</body>
</html>


<html>
  <body>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script>mermaid.initialize({startOnLoad:true});</script>
    
<a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_stateDiagrams.html">State diagrams</a>

    <div class="mermaid">
stateDiagram-v2
    [*] --> Still
    Still --> [*]
%% this is a comment
    Still --> Moving
    Moving --> Still %% another comment
    Moving --> Crash
    Crash --> [*]
        </div>
        
</body>
</html>

<html>
  <body>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script>mermaid.initialize({startOnLoad:true});</script>
    
<a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_ganttDiagrams.html">Gantt diagrams</a>

    <div class="mermaid">
    gantt
        apple :a, 2017-07-20, 1w
        banana :crit, b, 2017-07-23, 1d
        cherry :active, c, after b a, 1d
    </div>
        
</body>
</html>

<html>
  <body>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script>mermaid.initialize({startOnLoad:true});</script>
    
<a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_flowcharts.html">Flow charts</a>

    <div class="mermaid">
graph TB
    c1-->a2
    subgraph ide1 [one]
    a1-->a2
    end
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

<html>
  <body>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script>mermaid.initialize({startOnLoad:true});</script>
    
<a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_userJourney.html">User journey</a>

    <div class="mermaid">
journey
    title My working day
    section Go to work
      Make tea: 5: Me
      Go upstairs: 3: Me
      Do work: 1: Me, Cat
    section Go home
      Go downstairs: 5: Me
      Sit down: 5: Me
    </div>
</body>
</html>

<html>
  <body>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script>mermaid.initialize({startOnLoad:true});</script>
    
<a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_gitGraph.html">Git graph</a>

    <div class="mermaid">
gitGraph:
options
{
    "nodeSpacing": 150,
    "nodeRadius": 10
}
end
commit
branch newbranch
checkout newbranch
commit
commit
checkout master
commit
commit
merge newbranch

    </div>
</body>
</html>

<html>
  <body>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script>mermaid.initialize({startOnLoad:true});</script>
    
<a href="https://raw.githack.com/mzuer/mzuer.github.io/master/content/mermaid_otherExamples.html">Other examples</a>

    <div class="mermaid">
graph LR
    A[Square Rect] -- Link text --> B((Circle))
    A --> C(Round Rect)
    B --> D{Rhombus}
    C --> D
    </div>
</body>
</html>
