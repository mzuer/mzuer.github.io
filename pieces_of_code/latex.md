---
layout: default
title: "Pieces of code - LaTeX"
---

### Use columns to wrap text

```{latex}
\begin{columns}
  \begin{column}{0.3\textwidth}


  \end{column}

  \begin{column}{0.7\textwidth}


  \end{column}
\end{columns}
```


### Redefine margins locally (e.g. to extend out normal area) 

```{latex}
\usepackage{adjustbox}
\begin{adjustbox}{width=1.2\textwidth,center}
\end{adjustbox}

\begin{figure}
    \advance\leftskip-2cm
	\includegraphics[width=12cm]{result_struct_prot.pdf}          
\end{figure}
```

### Change document margin
```{latex}
\setbeamersize{text margin left=30mm,text margin right=30mm} 
```

#### Vertical top alignment 

globally by the t class option:

```{latex}
\documentclass[t]{beamer}
```

for single frames with the same option locally:

```{latex}
\begin{frame}[t]
...
\end{frame}
```
