---
layout: page
title: Articles
permalink: /articles/
---

<table id="posts" class="table">
    <col class="width-20">
    <col class="width-20"
    <col class="width-70">
    {% for post in site.posts %}
        <tr>
            <td>
                <span class="pull-right">{{ post.date | date: "%e %B %Y" }}</span>
            </td>

            {% if post.category == "Report" %}
                <td>
                    <span class="label label-success center-block category">{{ post.category }}</span>
                </td>
            {% endif %}
            {% if post.category == "Note" %}
                <td>
                    <span class="label label-default center-block category">{{ post.category }}</span>
                </td>
            {% endif %}
            {% if post.category == "Analysis" %}
                <td>
                    <span class="label label-info center-block category">{{ post.category }}</span>
                </td>
            {% endif %}

            <td>
                <a href="{{ post.url }}">{{ post.title }}</a>
            </td>
        </tr>
    {% endfor %}
</table>

