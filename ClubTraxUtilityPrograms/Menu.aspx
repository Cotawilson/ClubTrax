<%@ Page Title="" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="ClubTraxUtilityPrograms.Menu" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MenuContent" runat="server">
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">



     <table cellspacing="0" id="myTable" class="display">
      <thead>
        <tr>
           <th>ID</th>
           <th>  PLU </th>
           <th> Menu Item</th>
          <th> Sales Type </th>
          <th>Price Name</th>
           <th>Amount</th>
           <th>Discount Price </th>
        </tr>
      </thead>
      <tbody>
      </tbody>
    </table>

   <link href="https://cdn.datatables.net/v/dt/dt-1.13.4/b-2.3.6/date-1.4.0/fc-4.2.2/fh-3.3.2/r-2.4.1/rg-1.3.1/rr-1.3.3/sc-2.1.1/datatables.min.css" rel="stylesheet"/>
 
<script src="https://cdn.datatables.net/v/dt/dt-1.13.4/b-2.3.6/date-1.4.0/fc-4.2.2/fh-3.3.2/r-2.4.1/rg-1.3.1/rr-1.3.3/sc-2.1.1/datatables.min.js"></script>
    <script type="text/javascript">
        
        var JSONEventData = '<%= JSONincidentEvents %>';
        var table;
        $(document).ready( function () {
           
           
           
            
            let collapsedGroups = {};
            var result = $.parseJSON(JSONEventData);
            console.log(result);
           table = $('#myTable').DataTable({
               "paging": false,
                "pageLength": 1,
                 "info": false,
               "searching": true,
               "order": [[1, 'asc']],
               data: result,
               aoColumnDefs: [{
                   targets: [5],
                  createdCell: createdCell
               },
                   {
                       target: 0,
                       visible: false,
                   }],
               columns: [{ data: "nID" },
                   { data: "PLU" },
                   { data: "MenuItem" },
                   { data: "SalesType" },
                   { data: "PriceName" },
                   {
                       data: "nAmount",
                       render: $.fn.dataTable.render.number(',', '.', 2)
                   },
                   {
                       data: "nDiscountPrice",
                       render: $.fn.dataTable.render.number(',', '.', 2)    }
                  
                ],
               
               rowGroup: {
                   dataSrc: 'SalesType',
                   startRender: function (rows, group) {
                       let collapsed = !!collapsedGroups[group];
                       rows.nodes().each(function (r) {
                           r.style.display = 'none';
                           if (collapsed) {
                               r.style.display = '';
                           }
                       });
                       // Add category name to the <tr>. NOTE: Hardcoded colspan
                       return $('<tr/>')
                           .append('<td colspan="7">' + group + ' (' + rows.count() + ')<span class="glyphicon glyphicon-chevron-down"></span></td>')
                           .attr('data-name', group)
                           .toggleClass('collapsed', collapsed);
                   
                   }
               }
                       
        });
            $('#myTable tbody').on('click', 'tr', function () {
                console.log("onclick")
                let name = $(this).data('name');
                if (name) { 
               // console.log(this)
                collapsedGroups[name] = !collapsedGroups[name];
                table.draw(false);
            }
            });

          
           
           
        });
        const createdCell = function (cell) {
            let original;
            cell.setAttribute('contenteditable', true)
            cell.setAttribute('spellcheck', false)
            cell.addEventListener("focus", function (e) {
                console.log("focus")
                original = e.target.textContent
            })
            cell.addEventListener("blur", function (e) {
                if (original !== e.target.textContent) {
                    const row = table.row(e.target.parentElement)
                    //row.invalidate()
                    var newVal = e.target.textContent;
                    var plu = row.data().PLU;
                    var pName = row.data().PriceName;
                    console.log('Row changed: ', row.data().PLU)
                    dataMaintenanceUpdate(newVal, plu, pName)
                }
            })
        }

        //$('#myTable').on('input', function () { alert(1) });
        $('#myTable').on('change', '.cell-datatable', function (e) {
            var clickedRow = table.row(e.target.parentElement.parentElement)
            console.log(clickedRow)
            $(clickedRow).find('td').each(function () {
                console.log($(this).html($(html)))
                if ($(this).hasClass('editable')) {
                    if ($(this).hasClass('text')) {
                        //var html = fnCreateTextBox($(this).html(), 'name');
                        $(this).html($(html))
                    }
                }
            });

        });
      
       
        function dataMaintenanceUpdate(newVal, plu, pName) {
            // Update the data item.  
           //var parameterList = "{'PLU':'" + tableRow.PLU + "', " + "'amount':'" + tableRow.nAmount + "','priceName':'" + tableRow.PriceName + "'}";
            //var parameterList = "{'PLU': '";
            //console.log(parameterList)
            $.ajax({
                type: "POST",
                url: "Menu.aspx/UpdatePricingList",
                data: '{ PLU: "' + plu + '", amount: "'+newVal + '", priceName: "'+ pName + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //alert(response.message);
                    //  console.log(response.Message);
                    // if (response.hasOwnProperty('d')) response = response.d;
                    //if (response.Success == true) {
                    //alert(id);
                    $('.exception').html('');
                    $('.success').html(uName + ' successfully updated.');

                    tableRow.find('#activeLabel').text(active);
                    tableRow.find('#uNameLabel').text(uName);
                    


                    resetTable(tableRow.parent().parent().id);
                    //console.log(tableRow);
                   // updateDataTable(tableRow);
                    // } else {
                    //$('.exception').html('Error occurred attempting to update the ' + division + '. Please contact the</br>' +
                    //'Service Desk @ (918) 596-7070 to report the error.</br>' + response.Message);
                    // $('.success').html('');
                    //}
                },
                error: function (xhr) {
                    $('.exception').html('Error occurred attempting to update the UserName. Please contact the</br>' +
                        'Service Desk @ (918) 596-7070 to report the error.</br>' + xhr.responseText);
                    $('.success').html('');
                }
            });
        }
        
        
    </script>



	</html>
    </asp:Content>









