---
published: true
pin: true
id: 1342699f-fab6-80d4-8c17-d6fd06be47a3
title: 个人博客搭建GitHubPages+Jekyll+Jekyll-Notion
created_time: 2024-11-04T10:08:00.000Z
cover: 
icon: 🚓
last_edited_time: 2024-11-05T06:38:00.000Z
archived: false
created_by_object: user
created_by_id: a3aba19d-7c0f-44c8-a6b1-4f5dd3281b2e
last_edited_by_object: user
last_edited_by_id: a3aba19d-7c0f-44c8-a6b1-4f5dd3281b2e
---

# 目标

本文的目标是基于GitHub Pages托管仓库，利用Jekyll静态网站生成方案部署个人网站，同时接入Jekyll-Notion（Jekyll插件）以实现利用Notion写作，利用GitHub仓库提供的CI功能——操作（Actions），同步到GitHub Pages个人网站。

### 目标细分

- 选择一个主题建立GitHub Pages仓库
- CI创建，自动构建以及部署网站，实现静态网站
- 创建Notion集成
- 同步Notion页面到网站

# 优缺点

## 优点

- 方便分享内容
- 无需担心图片存储，Notion页面导出后，其中的图片托管到AWS，用户无感，图片清晰
- 以标签（Tag）和目录（Category）分类文章，提供全局搜索功能
- 与Notion数据库集成，可以在Notion中直接维护网站内容，可视化表格，属性修改，功能强大且直观
- 维护个人网站的成就感

## 缺点

- Jekyll-Notion导出Notion页面未实现标签归纳和目录整理功能，仅原生博客/帖子可以归纳到标签和目录
- Jekyll-Notion导出Notion页面不支持部分特性，例如子页面，但大部分支持
- 需要对Notion导出为markdown格式的特性支持和Jekyll属性支持有基本了解，**后面的步骤中我会为一一补充基础知识点**

<br />

# 开始搭建

> 在之后的步骤中，我的有些说明是想让你更好理解博客搭建步骤，但如果你感到困扰或者有些难以前进，我推荐先看[这篇文章](https://zzy979.github.io/posts/creating-personal-blog-site/)
{: .prompt-warning }

## 选择一个主题建立GitHub Pages仓库

### 基础知识（帮助你了解之后的步骤在做什么/非必要）

- GitHub Pages
如果你还不了解GitHub Pages，那么GitHub Pages是由 GitHub 托管和发布的公共网页，新建一个仓库并严格命名仓库名为`<你的username>.github.io`，就可以创建每个用户仅有的一个GitHub Pages仓库。GitHub会提供一个`**https://<你的username>.github.io**`作为访问此公共网站的域名。

> 进一步了解GitHub Pages站点.[https://docs.github.com/zh/pages/quickstart](https://docs.github.com/zh/pages/quickstart)
{: .prompt-info }

- Jekyll
Jekyll是GitHub Pages官方支持的一种静态网站生成方案，你可以在本地安装开发环境以生成网站并在本地调试。但本地环境是非必要的，因为GitHub Actions可以直接帮助构架网站并部署

> 更多Jekyll知识.[https://jekyllrb.com/docs/](https://jekyllrb.com/docs/)
{: .prompt-info }

- Jekyll主题
Jekyll主题为你”贫瘠”的网站提供了基本的样式和结构，让你不用接触基础又恶心的Html，CSS编写

> 更多Jekyll主题以及知识.[https://jekyllrb.com/docs/themes/](https://jekyllrb.com/docs/themes/)
{: .prompt-info }


### 建立仓库

首先我们要选择一个Jekyll主题作为网站模板，这里我选择使用chirpy，打开[chirpy-starter](https://github.com/cotes2020/chirpy-starter)仓库，点击按钮 “Use this template” → “Create a new repository”。

![](assets/post-images/create-repository-step1.png)

将新仓库命名为`<username>.github.io`，其中`<username>`是你的GitHub用户名，如果包含大写字母需要转换为小写。


![](assets/post-images/C2XNOW9_9KB97ENNJBO.png)

我这里已经创建过了所以报红。其次仓库最好是Public，不确定Private有无影响。至此我们已经建立了一个基本的网站仓库。

## CI创建，自动构建以及部署网站，实现静态网站

### 基础知识

GitHub Action是GitHub提供的一种CI自动化方法，能够根据仓库情况触发某些自动化操作，我们利用GitHub Action来自动化构建，部署网站到域名

![](assets/post-images/Create_Github_Action.png)

进入仓库，选择Settings，选择Pages，将`Build and deployment`下的Source改为GitHub Actions，**GitHub将自动为你选择Jekyll站点部署的自动化CI，在每次仓库Push后触发。你也可以配置成定时触发。但这超出了本文的范围。**你可以选中GitHub Actions下的配置来进行更多自定义

![](assets/post-images/AZJ%29CEWQ84%29GV2M0LPKN.png)

> 注意GitHub Action是否完成，过一会输入你的域名，应该就可以访问到基本的网页，样式大概像上图我的博客这样
{: .prompt-tip }

恭喜，到这一步，你部署了你的基本网站，你可以利用上面提到的Jekyll知识点来创建一些原生的Jekyll页面并开始你的写作。

## 创建Notion集成

这一步我们将创建Notion与Jekyll网站的关联条件——Notion集成

### 基础知识

简单来说，Notion集成是一种连接，当我们创建了一个Notion集成，我们可以在Notion中将页面或者数据库关联到集成，外部的应用可以利用Notion集成所代表的Token来调用Notion API获取Notion数据。获取Notion数据是我们抓取Notion页面的基础

### 创建步骤

![](assets/post-images/852WS%29A1%282ROWGP402H.png)

打开[https://www.notion.so/profile/integrations](https://www.notion.so/profile/integrations)，点击创建新的集成，我们使用内部集成即可

![](assets/post-images/SZVRXFY3M48GK31JXLETY.png)

创建完成之后我们可以修改集成配置，红框部分是不必要的，需要重点关注的是TOKEN，将其复制下来保存在本地，之后我们会用到。**集成的名字无关紧要。**

![](assets/post-images/KR6UE3NYNBM57G.png)

<br />

至此我们完成了Notion集成的创建，接下来我们要配置Jekyll的配置文件，获取我们Notion的概念数据库Id/页面Id，来建立Jekyll网页生成和Notion的联系

## 同步Notion页面到网站

### 基础知识

- Notion概念数据库，简单来说就是Notion的数据表格，我们将数据表格关联到Notion集成，以数据表格作为与Jekyll关联的桥梁

### 步骤

先到你的Notion创建一个<u>**数据表格页面，一定要是Full Page**</u>

![](assets/post-images/Y3LD6DECYQ01ES9%28V33J.png)

之后我们将整个页面关联到我们上一步创建的Notion集成

![](assets/post-images/JP6FZQVFF0CUM26T9LIJ.png)

同时要将子页面也纳入集成

![](assets/post-images/image.png)

<br />

恭喜，我们完成了Notion单方面集成关联，可以到Jekyll中进行进一步配置了。

现在，先找到我们的仓库，将我们的上面保存的Notion集成的Notion Token设置到秘密环境变量，以便后续CI的时候可以捕获

![](assets/post-images/M93FOZ50U%28C22%287_XOKUP.png)

<br />

现在，选择一个Git工具将你的仓库Clone到本地，我使用Fork

![](assets/post-images/%280EA84KCD6KB8YX9OQF.png)

<br />

> 可以到Jekyll-Notion的仓库页面了解一些基础知识
{: .prompt-tip }

我们需要关注的是仓库根目录下的

- config.yml，这是网站的配置文件，参照其中的注释将网站的配置改为自己的，例如头像，网站主页名，网站标题，作者等，[更多信息](https://github.com/cotes2020/jekyll-theme-chirpy)。**我的配置****[在这](https://github.com/aresfor/aresfor.github.io/blob/main/_config.yml)****，除了一些个人信息需要修改，你只需要关注配置头部有关notion的部分**
- Gemfile，这是网站依赖文件，可以直接使用[我的](https://github.com/aresfor/aresfor.github.io/blob/main/Gemfile)
- .github/workflow/pages-deploy.yml，这是GitHub Actions的配置文件。其中需要一些额外配置，你可以直接使用[我的](https://github.com/aresfor/aresfor.github.io/blob/main/.github/workflows/pages-deploy.yml)。

<br />

![](assets/post-images/Y_ORUCE0I8VULUL4VLTI.png)

databases配置解释

- id，理论上我们可以利用多个Notion的概念数据库，概念数据库就是我们上一步创建的Notion数据表格，选择Copy Link，我们可以得到一个链接，其中一部分就是我们需要的数据库id
![](assets/post-images/image.png)

![](assets/post-images/039OLTG2B%29R05%29U364K2%29J.png)

- collection，对应我们根目录下的_posts文件夹，当然你也可以创建其他collection，目前我推荐就是用posts就行了

填充好你的databaseId之后，我们就完成了Notion和Jekyll的双向关联！还缺了点什么，我们来填充一些文章。

这一步你可以自己尝试。我目前大概会这样做

> 你可能会好奇我添加的Tags，Categories属性，原理上讲，数据表格的特定命名的属性可以影响到网页的生成。这一步的讨论已经超过了本文的范围，更多可以到[Jekyll-Notion](https://github.com/emoriarty/jekyll-notion)和[NotionTomd](https://github.com/emoriarty/notion_to_md)了解
{: .prompt-tip }

![](assets/post-images/QWNUR8VBHHL3P%28M1JC.png)

创建完你的博客之后，我们将对_config.yml和GemFile，以及一些你可能的自定义修改Push到GitHub仓库，触发自动化构建，过一会，你就可以访问你的域名看到你的网页了！

<br />

## 评论系统

你可能想要添加一个评论系统，这是我给阅读文章的你留下的课后作业~~（我已经写不动了）~~，你可以参考[这篇博客](https://zzy979.github.io/posts/creating-personal-blog-site/)的评论系统部分，相比前面的内容，这部分不算难。

<br />

## 可能的问题

自动化构建过程中你可能会碰到下面的错误。这是站点测试未通过报错。还记得我在上面说过的吗？Jekyll-Notion不支持标签归纳和目录整理，而我在我的Notion数据表格中添加了这两列属性，可以自己修改插件Ruby代码，但这超出了本文的范围，目前只有将这些Tag先进性移除了。

![](assets/post-images/7Z0QPXHAEPFD%29A37W2ZB.png)

<br />

![](assets/post-images/YA%29BOGX34FG9OMX7V6.png)

## 尾声

我按照我的博客搭建思路撰写了本文，如果你遇到任何困难，可以在评论区告诉我，通常我会很快回复。

<br />


