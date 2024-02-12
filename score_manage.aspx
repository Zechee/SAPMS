﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="score_manage.aspx.cs" Inherits="score_m.score_manage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Grade Management</title>
    <link rel="stylesheet" href="resource/sweetalert-11.4.14/sweetalert2.css" />
    <script src="resource/sweetalert-11.4.14/sweetalert2.js"></script>
    <link rel="stylesheet" href="resource/css/base.css" />
    <style>
        .cont {
            width: 100%;
            height: 100%;
            padding: 10px;
        }

            .cont > div {
                width: 100%;
            }

        cont > div:nth-child(n+1) {
            height: calc(100% - 30px);
        }

        .nav {
            height: 30px;
            display: flex;
            flex-flow: row;
            justify-content: flex-start;
            align-items: center;
            text-align: center;
            border-bottom: 1px solid var(--base_border_color);
            margin-bottom: 10px;
        }

            .nav > div {
                height: 100%;
                width: 90px;
                margin-right: 5px;
                cursor: pointer;
            }

            .nav > .active {
                border-bottom: 2px solid var(--base_active_color);
                color: var(--base_active_color);
            }
    </style>
    <script>
        window.onload = function () {
            hideAll();
            changeFunc("show");
        }
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
            didOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer)
                toast.addEventListener('mouseleave', Swal.resumeTimer)
            }
        })
        function hideAll() {
            document.querySelector('.show-cont').style.display = "none"
            document.querySelector('.search-cont').style.display = "none"
            document.querySelector('.add-cont').style.display = "none"
            document.querySelector('.nav > div:nth-child(1)').classList.remove('active');
            document.querySelector('.nav > div:nth-child(2)').classList.remove('active');
            document.querySelector('.nav > div:nth-child(3)').classList.remove('active');
        }
        function changeFunc(func) {
            hideAll();
            switch (func) {
                case "show":
                    document.querySelector('.nav > div:nth-child(1)').classList.add('active');
                    document.querySelector('.show-cont').style.removeProperty("display")
                    break
                case "search":
                    document.querySelector('.nav > div:nth-child(2)').classList.add('active');
                    document.querySelector('.search-cont').style.removeProperty("display")
                    break;
                case "add":
                    document.querySelector('.nav > div:nth-child(3)').classList.add('active');
                    document.querySelector('.add-cont').style.removeProperty("display")
                    break;
                default: break;
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="cont">
            <div class="nav">
                <div onclick="changeFunc('show')">List</div>
                <div onclick="changeFunc('search')">Search</div>
                <div onclick="changeFunc('add')">Add New</div>
            </div>
            <div class="show-cont">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" class="select-cont">
                    <ContentTemplate>
                        <div class="select-item">
                            <span>Class:</span>
                            <div>
                                <asp:DropDownList ID="classDropList"
                                    DataTextField="name"
                                    DataValueField="classid"
                                    runat="server"
                                    AutoPostBack="true"
                                    OnSelectedIndexChanged="classDropList_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="select-item">
                            <span>Subject:</span>
                            <div>
                                <asp:DropDownList ID="subjectDropList"
                                    runat="server"
                                    AutoPostBack="true"
                                    DataTextField="name"
                                    DataValueField="subid"
                                    OnSelectedIndexChanged="subjectDropList_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="classDropList" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" class="list-cont">
                    <ContentTemplate>
                        <div class="list-item">
                            <asp:GridView ID="scoreList" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" Width="100%">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:BoundField HeaderText="Student ID" DataField="sid" HtmlEncode="False"></asp:BoundField>
                                    <asp:BoundField HeaderText="Name" DataField="name" HtmlEncode="False"></asp:BoundField>
                                    <asp:BoundField HeaderText="Grade" DataField="grade" HtmlEncode="False"></asp:BoundField>
                                    <asp:BoundField HeaderText="Total Score" DataField="total" DataFormatString="{0:F0}" HtmlEncode="False"></asp:BoundField>
                                    <asp:BoundField HeaderText="Date of Birth" DataField="birth" DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="False"></asp:BoundField>
                                    <asp:BoundField HeaderText="Class" DataField="class" HtmlEncode="False"></asp:BoundField>
                                </Columns>
                                <EditRowStyle BackColor="#F5F7FA" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#EFF3FB" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                <SortedDescendingHeaderStyle BackColor="#4870BE" />
                            </asp:GridView>
                        </div>
                        <div class="list-item">
                            <asp:GridView ID="overView" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:BoundField HeaderText="Average Score" DataField="average" DataFormatString="{0:F2}" HtmlEncode="False"></asp:BoundField>
                                    <asp:BoundField HeaderText="Highest Score" DataField="max" DataFormatString="{0:F1}" HtmlEncode="False"></asp:BoundField>
                                    <asp:BoundField HeaderText="Lowest Score" DataField="min" DataFormatString="{0:F1}" HtmlEncode="False"></asp:BoundField>
                                    <asp:BoundField HeaderText="Number of Examinees" DataField="testCount" DataFormatString="{0:F0}" HtmlEncode="False"></asp:BoundField>
                                    <asp:BoundField HeaderText="Class Size" DataField="classCount" DataFormatString="{0:F0}" HtmlEncode="False"></asp:BoundField>
                                    <asp:BoundField HeaderText="Number of Passes" DataField="passCount" DataFormatString="{0:F0}" HtmlEncode="False"></asp:BoundField>
                                    <asp:BoundField HeaderText=" Number of Excellents" DataField="goodCount" DataFormatString="{0:F0}" HtmlEncode="False"></asp:BoundField>
                                </Columns>
                                <EditRowStyle BackColor="#F5F7FA" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#EFF3FB" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                <SortedDescendingHeaderStyle BackColor="#4870BE" />
                            </asp:GridView>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="scoreList" EventName="DataBound" />
                        <asp:AsyncPostBackTrigger ControlID="scoreList" EventName="DataBound" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <div class="search-cont">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server" class="select-cont">
                    <ContentTemplate>
                        <div class="select-item">
                            <span>Search Criteria:</span>
                            <div>
                                <asp:DropDownList ID="searchDropList" runat="server">
                                    <asp:ListItem Value="name">Name</asp:ListItem>
                                    <asp:ListItem Value="sid">Student ID</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="select-item">
                            <div>
                                <asp:TextBox ID="searchInput" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="select-item">
                            <asp:Button ID="searchBt" runat="server" Text="Search" OnClick="searchBt_Click" class="primary-button" />
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="searchBt" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
                <asp:UpdatePanel ID="UpdatePanel4" runat="server" class="list-cont">
                    <ContentTemplate>
                        <div class="list-item">
                            <asp:GridView ID="studentScore" runat="server"
                                AutoGenerateColumns="False"
                                OnRowDeleting="studentScore_RowDeleting"
                                OnRowCancelingEdit="studentScore_RowCancelingEdit"
                                OnRowEditing="studentScore_RowEditing"
                                OnRowUpdating="studentScore_RowUpdating" CellPadding="4" ForeColor="#333333">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:BoundField HeaderText="ID" DataField="scoreid" HtmlEncode="false" />
                                    <asp:BoundField HeaderText="Subject Name" DataField="subject" HtmlEncode="False"></asp:BoundField>
                                    <asp:BoundField HeaderText="Subject Code" DataField="subid" HtmlEncode="False"></asp:BoundField>
                                    <asp:BoundField HeaderText="Grade" DataField="grade" HtmlEncode="False"></asp:BoundField>
                                    <asp:BoundField HeaderText="Total Score" DataField="total" DataFormatString="{0:F0}" HtmlEncode="False"></asp:BoundField>
                                    <asp:CommandField ShowDeleteButton="true" DeleteText="Delete" ButtonType="Button">
                                        <ControlStyle CssClass="danger-button" />
                                    </asp:CommandField>
                                    <asp:CommandField ShowEditButton="true" ButtonType="Button" CancelText="Return">
                                        <ControlStyle CssClass="primary-button" />
                                    </asp:CommandField>
                                </Columns>
                                <EditRowStyle BackColor="#F5F7FA" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#EFF3FB" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                <SortedDescendingHeaderStyle BackColor="#4870BE" />
                            </asp:GridView>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="studentScore" EventName="DataBound" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <div class="add-cont">
                <asp:UpdatePanel ID="UpdatePanel5" runat="server" class="insert-cont">
                    <ContentTemplate>
                        <div class="insert-form">
                            <div class="insert-form-item">
                                <span>Name:</span>
                                <div>
                                    <asp:DropDownList ID="add_nameDropList"
                                        DataTextField="name"
                                        DataValueField="sid"
                                        runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="insert-form-item">
                                <span>Subject:</span>
                                <div>
                                    <asp:DropDownList ID="add_subjectDropList"
                                        DataTextField="name"
                                        DataValueField="subid"
                                        runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="insert-form-item">
                                <span>Score:</span>
                                <div>
                                    <asp:TextBox ID="add_gradeInput" runat="server" onkeyup="if(isNaN(value))execCommand('undo')"></asp:TextBox>
                                </div>
                            </div>
                            <div class="insert-form-item submit-item">
                                <div>
                                    <asp:Button ID="addBt" runat="server" Text="Add New" OnClick="addBt_Click" CssClass="primary-button" />
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="addBt" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </form>
</body>
</html>
