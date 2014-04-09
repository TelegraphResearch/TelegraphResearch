---
layout: page
title: Reports
permalink: /reports/
---

<table id="posts" class="table">
    <col class="width-30">
    <col class="width-70">
    {% for post in site.posts %}
        <tr>
            <td>
                <span class="pull-right">{{ post.date | date: "%e %B %Y" }}</span>
            </td>
            <td>
                <a href="{{ post.url }}">{{ post.title }}</a>
            </td>
        </tr>
    {% endfor %}
</table>

{% include signup.html %}
