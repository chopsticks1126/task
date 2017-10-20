<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- easyui依赖的jquery库 -->
<script type="text/javascript" src="../jslib/jquery-easyui-1.5.3/jquery.min.js"></script> 
<!-- easyui核心库 -->
<script type="text/javascript" src="../jslib/jquery-easyui-1.5.3/jquery.easyui.min.js"></script>
<!-- 国际化文件：中文 -->
<script type="text/javascript" src="../jslib/jquery-easyui-1.5.3/locale/easyui-lang-zh_CN.js"></script> 
<!-- 引入样式文件 -->
<link rel="stylesheet" href="../jslib/jquery-easyui-1.5.3/themes/default/easyui.css" type="text/css"></link>
<!-- 引入相关的icon文件 -->
<link rel="stylesheet" href="../jslib/jquery-easyui-1.5.3/themes/icon.css" type="text/css"></link>
<title>Welcome Travel</title>
</head>
<body>
    <table id="dg" title="My MsgInfo" class="easyui-datagrid" style="width:700px;height:250px"
            url="../ShowMsgDate/showMsgInfoDate.do"
            toolbar="#toolbar" 
            rownumbers="true" fitColumns="true" singleSelect="true">
        <thead>
            <tr>
                <th field="name" width="50">name</th>
                <th field="phone" width="50">phone</th>
                <th field="email" width="50">email</th>
            </tr>
        </thead>
    </table>
<!--     <div id="pp" class="easyui-pagination" style="background:#efefef;border:1px solid #ccc;width:700px;"></div>  -->
    <div id="toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">New User</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">Edit User</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">Remove User</a>
    </div>
    
    <div id="dlg" class="easyui-dialog" style="width:400px"
            closed="true" buttons="#dlg-buttons">
        <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
            <div style="margin-bottom:20px;font-size:14px;border-bottom:1px solid #ccc">User Information</div>
            <div style="margin-bottom:10px">
                <input name="firstname" class="easyui-textbox" required="true" label="First Name:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="lastname" class="easyui-textbox" required="true" label="Last Name:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="phone" class="easyui-textbox" required="true" label="Phone:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="email" class="easyui-textbox" required="true" validType="email" label="Email:" style="width:100%">
            </div>
        </form>
    </div>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveUser()" style="width:90px">Save</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">Cancel</a>
    </div>
    <script type="text/javascript">

$(function(){
		    $('#pp').pagination({
		    	pageList: [10,20,50,100],
		    	onSelectPage:function(pageNumber, pageSize){
		    		$(this).pagination('loading');
		    		var handler = "../ShowMsgDate/showMsgInfoDate.do?pages=" + escape(pageNumber)+ "&pageSize=" + escape(pageSize);
		    		alert('pageNumber:'+pageNumber+',pageSize:'+pageSize);
		    		 $('#dg').datagrid('options').url = handler;
// 		    		 $('#pp').linkbutton({required:true});
		    		 $('#dg').datagrid('reload'); //重新加载表格
		    		$(this).pagination('loaded');
		    	}
		    });
// 		}


});    
        
        
$('#pp').pagination({ 
	total:2000, 
	pageSize:10 
	}); 


        
        
        
        var url;
					function newUser() {
						$('#dlg').dialog('open').dialog('center').dialog(
								'setTitle', 'New User');
						$('#fm').form('clear');
						url = 'save_user.php';
					}
					function editUser() {
						var row = $('#dg').datagrid('getSelected');
						if (row) {
							$('#dlg').dialog('open').dialog('center').dialog(
									'setTitle', 'Edit User');
							$('#fm').form('load', row);
							url = 'update_user.php?id=' + row.id;
						}
					}
					function saveUser() {
						$('#fm').form('submit', {
							url : url,
							onSubmit : function() {
								return $(this).form('validate');
							},
							success : function(result) {
								var result = eval('(' + result + ')');
								if (result.errorMsg) {
									$.messager.show({
										title : 'Error',
										msg : result.errorMsg
									});
								} else {
									$('#dlg').dialog('close'); // close the dialog
									$('#dg').datagrid('reload'); // reload the user data
								}
							}
						});
					}
					function destroyUser() {
						var row = $('#dg').datagrid('getSelected');
						if (row) {
							$.messager
									.confirm(
											'Confirm',
											'Are you sure you want to destroy this user?',
											function(r) {
												if (r) {
													$
															.post(
																	'destroy_user.php',
																	{
																		id : row.id
																	},
																	function(
																			result) {
																		if (result.success) {
																			$(
																					'#dg')
																					.datagrid(
																							'reload'); // reload the user data
																		} else {
																			$.messager
																					.show({ // show error message
																						title : 'Error',
																						msg : result.errorMsg
																					});
																		}
																	}, 'json');
												}
											});
						}
					}
				</script>
</body>
</html>