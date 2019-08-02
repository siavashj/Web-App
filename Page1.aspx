<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Page1.aspx.cs" Inherits="WebAppTest4Siavash.Page1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://d3js.org/d3.v3.min.js"></script>    
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <style>
    
    .axis text {
    font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
    font-size: 13px;
}

.grid line {
  stroke: lightgrey;
  stroke-opacity: 0.3;
  shape-rendering: crispEdges;
}

.axis path,
.axis line {
    fill: none;
    stroke: grey;
    stroke-width: 2;
    shape-rendering: crispEdges;
}

.tick text{
    font-size: 12px;
    font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
  }

  .tick line{
    opacity: 0.2;
  }

  .liquidFillGaugeText { font-family: Helvetica; font-weight: bold; }
</style>
    <title>Report Results</title>
    <script>
        var myDataFromServer = [<%= data4Graph %>];
        function onloadFcn() {
            document.getElementById('test1').style.color = 'blue';            
            GraphNoInstantaniousSwimmers(myDataFromServer, 'test1');
            document.getElementById('test1').style.color = 'red';            
            //plotMyBarGraph(myDataFromServer);
        }
function GraphNoInstantaniousSwimmers(data, legendText) {
        // Set the dimensions of the canvas / graph
    var WidthColVisualisation = document.getElementById("ColVisualisation3").offsetWidth;
    var HeightColVisualisation = document.getElementById("ColVisualisation3").offsetHeight;

    var margin = { top: 10, right: 20, bottom: 30, left: 200 },
        width = WidthColVisualisation - margin.left - margin.right - 70,
        height = 170 - margin.top - margin.bottom - 50,
        legendRectSize = 18,            
        legendSpacing = 4; 

    // set the ranges
    var x = d3.time.scale().domain(d3.extent(data, function(d) { return d.order; })).range([0, width]);//.domain(d3.extent(data, function(d) { return d.year; }))
    var y = d3.scale.linear().domain([0, d3.max(data, function(d) { return d.value; })]).range([height, 0]);//.domain([0, d3.max(data, function(d) { return d.sale; })])
    
    // Define the axes
    var xAxis = d3.svg.axis().scale(x)                
        .orient("bottom").ticks(data.length).innerTickSize(-height)
        .outerTickSize(0)
        .tickPadding(1)
        .ticks(data.length);

    var yAxis = d3.svg.axis().scale(y)
        .orient("left").ticks(4);
           
    var color = d3.scale.linear()
          .range(["rgb(90,90,110)", "rgb(72,139,73)", "rgb(90,100,90)", "rgb(238,104,100)"]);
    
    // Adds the svg canvas        
    var svg = d3.select("#svgObj1")   
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append("g")
        .attr("transform","translate(" + margin.left + "," + margin.top + ")");

    // Define the line value
    var valueline = d3.svg.line().x(function (d) { return x(d.order); }).y(function (d) { return y(d.value); }).interpolate("linear");
    svg.append("path")       
        .attr("class", "line")
        .attr("d", valueline(data))
        .attr("stroke", color(0))
        .attr("fill", "none")
        .style("stroke-dasharray", ("3, 3"))
        .attr("stroke-width", "3");
    svg.selectAll("dot")
        .data(data)
        .enter().append("circle")
        .attr("r", 3.5)
        .attr("cx", function(d) { return x(d.order); })
        .attr("cy", function (d) { return y(d.value); });

    // Add the X Axis
    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis);
  
    // Add the Y Axis
    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis);  
    
     
   
    
    var legend = svg.selectAll('.legend')                     
          .data(legendText)                                   
          .enter()                                                
          .append('g')                                            
          .attr('class', 'legend')                                
          .attr('transform', function(d, i) {                     
            var height = legendRectSize + legendSpacing;          
            var offset =  0 ;     
            var horz = -margin.left;                       
            var vert = i * height - offset;                       
            return 'translate(' + horz + ',' + vert + ')';        
        });       
    
        legend.append('rect')                                    
            .attr('width', legendRectSize) 
          .attr('height', legendRectSize)                         
          .style('fill', function (d,i) { return color(i); })                                   
          .style('stroke', 'gray');                                
          
        legend.append('text')  
          .data(legendText)
          .attr('x', legendRectSize + legendSpacing)              
          .attr('y', legendRectSize - legendSpacing)              
          .text(function(d) { return d; }); 

        //document.getElementById("testText").innerHTML = "test";  
    }
    </script>
</head>
<body onload="onloadFcn()">   
    <div id="test1" onclick=""> test1 </div>
    <div class="container-fluid" style="height:100%;padding-top:20px;">
        <div class="row justify-content-center">
            <div class="col col-sm-10">
                <div class="row">
                    <form id="form1" runat="server" style="width:100%;">                        
                        <div class="input-group mb-lg-auto" >                          
                          <asp:TextBox runat="server" ID="FilterType_TextBox"  class="form-control" placeholder="Filter Type" aria-label="Filter Type" aria-describedby="button-addon2"></asp:TextBox>
                          <div class="input-group-append">
                            <asp:Button runat="server" ID="FilterType_Button" class="btn btn-primary" OnClick="SubmitBtn_Click"  Text="Refine" />
                          </div>
                        </div>
                    </form>
                </div>
                <div class="row" style="padding-top:20px;">
                    <div class="col col-6">
                        <div class="card border-primary rounded-lg shadow-sm">
                            <div class="card-header"> Table of Results</div>
                            <div class="card-body" >
                                <table class="table">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th scope="col">
                                                #
                                            </th>
                                            <th scope="col">
                                                Type
                                            </th>
                                            <th scope="col">
                                                Value
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody runat="server" id="TableBodyContent">
                                        
                                    </tbody>
                                </table>
                            </div>
                            <div class="card-footer"> Num of records: <font runat="server" id="NumOfRecords_DIV" style="font-weight:800"></font> </div>
                        </div>
                    </div>                    
                    <div class="col col-6">
                        <div class="col" id="ColVisualisation3">
                            <svg id="svgObj1" width="100%" height="500" style="background-color:#eeeeee"></svg>
                        </div>
                    </div>
                </div>                
            </div>            
        </div>
    </div>



</body>
</html>
