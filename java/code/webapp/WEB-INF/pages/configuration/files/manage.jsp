<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://rhn.redhat.com/rhn" prefix="rhn" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://rhn.redhat.com/tags/config-managment" prefix="cfg" %>


<html>
<body>

<%@ include file="/WEB-INF/pages/common/fragments/configuration/files/manage_header.jspf" %>
<form method="post" name="rhn_list"
        action="/rhn/configuration/file/ManageRevisionSubmit.do?cfid=${file.id}">
    <rhn:csrf />
        <rhn:list pageList="${requestScope.pageList}"
                  noDataText="manage.jsp.noRevisions">

      <rhn:listdisplay set="${requestScope.set}"
                       button="manage.jsp.delete"
                       buttonAcl="config_channel_editable(${channel.id})"
                       mixins="com.redhat.rhn.common.security.acl.ConfigAclHandler">
        <rhn:require acl="config_channel_editable(${channel.id})"
                     mixins="com.redhat.rhn.common.security.acl.ConfigAclHandler">
                  <rhn:set value="${current.id}"/>
                </rhn:require>

                <rhn:column header="manage.jsp.name">
                        <a href="/rhn/configuration/file/FileDetails.do?crid=${current.id}&amp;cfid=${file.id}">
                          <cfg:file nolink="true" id="${file.id}" revisionId="${current.id}"  path="${file.configFileName.path}" type="${file.latestConfigRevision.configFileType.label}" />
                          <bean:message key="manage.jsp.revision"
                                        arg0="${current.revisionNumber}"/>
                        </a>
        </rhn:column>

        <rhn:require acl="is_file()"
                     mixins="com.redhat.rhn.common.security.acl.ConfigAclHandler">
          <rhn:column header="manage.jsp.size">
            ${current.sizeDisplay}
          </rhn:column>
        </rhn:require>

        <rhn:column header="manage.jsp.creation">
            ${current.createdDisplay}
        </rhn:column>
      </rhn:listdisplay>
    </rhn:list>
</form>

<rhn:require acl="is_file();config_channel_editable(${channel.id})"
             mixins="com.redhat.rhn.common.security.acl.ConfigAclHandler">
    <%@ include file="/WEB-INF/pages/common/fragments/configuration/files/upload.jspf" %>
</rhn:require>

</body>
</html>

