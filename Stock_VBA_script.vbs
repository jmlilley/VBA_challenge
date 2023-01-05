Attribute VB_Name = "Module1"
Sub stock_date():
    'loop through all worksheets
    For Each ws In Worksheets
        
        'create all global variables
        Dim output_row As Integer
        output_row = 2
    
        Dim ticker As String
        Dim opening_price As Variant
        Dim closing_price As Variant
        Dim yearly_change As Variant
        Dim percentage_change As Variant
        
        Dim stock_volume As Variant
        stock_volume = 0
    
        Dim counter As Variant
        counter = 0
        
        'get number of rows for each ws
        lastrow = ws.Cells(Rows.Count, 1).End(xlUp).Row
        
        'add column headers
        ws.Range("J1").Value = "Ticker"
        ws.Range("Q1").Value = "Ticker"
        ws.Range("K1").Value = "Yearly Change"
        ws.Range("L1").Value = "Percent Change"
        ws.Range("M1").Value = "Total Stock Volume"
        ws.Range("R1").Value = "Value"
    
        ws.Range("P2").Value = "Greatest % Increase"
        ws.Range("P3").Value = "Greatest % Decrease"
        ws.Range("P4").Value = "Greatest Total Volume"
        
        'Bonus global variables
        Dim increase As Variant
        Dim decrease As Variant
        Dim volume As Variant
        Dim bonus_increase_ticker As String
        Dim bonus_decrease_ticker As String
        Dim bonus_volume_ticker As String
    
        increase = 0
        decrease = 0
        volume = 0
        bonus_increase_ticker = ""
        bonus_decrease_ticker = ""
        bonus_volume_ticker = ""
                
        For i = 2 To lastrow
            'when ticker in current row does not equal ticker in next row
            If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
                'get ticker info and output
                ticker = ws.Cells(i, 1).Value
                ws.Cells(output_row, 10).Value = ticker
                
                'output total stock volume for ticker
                ws.Cells(output_row, 13).Value = stock_volume
                                
                'calculate prices
                opening_price = ws.Cells(i - counter, 3).Value
                closing_price = ws.Cells(i, 6).Value
                yearly_change = (closing_price - opening_price)
                percentage_change = ((closing_price - opening_price) / opening_price)
                
                'output prices
                ws.Cells(output_row, 11).Value = yearly_change
                ws.Cells(output_row, 12).Value = percentage_change
                    'adjust cells syle to percentage
                    ws.Cells(output_row, 12).NumberFormat = "0.00%"
                
                'conditional formating for output cells
                If yearly_change < 0 Then
                    ws.Cells(output_row, 11).Interior.ColorIndex = 3
                    ws.Cells(output_row, 12).Interior.ColorIndex = 3
                Else
                    ws.Cells(output_row, 11).Interior.ColorIndex = 4
                    ws.Cells(output_row, 12).Interior.ColorIndex = 4
                End If
                                            
                'bonus greatest increase
                If percentage_change > increase Then
                    increase = percentage_change
                    bonus_increase_ticker = ticker
                End If
                
                'bonus greatest decrease
                If percentage_change < decrease Then
                    decrease = percentage_change
                    bonus_decrease_ticker = ticker
                End If
                
                'bonus greatest total volume
                If volume < stock_volume Then
                    volume = stock_volume
                    bonus_volume_ticker = ticker
                End If
                
                'adjust counter variables
                output_row = output_row + 1
                counter = 0
                stock_volume = 0
                
            Else
                stock_volume = stock_volume + ws.Cells(i, 7).Value
                
                counter = counter + 1
            End If
            
        Next i
        
        'output bonus results
        ws.Range("Q2").Value = bonus_increase_ticker
        ws.Range("Q3").Value = bonus_decrease_ticker
        ws.Range("Q4").Value = bonus_volume_ticker
        
        ws.Range("R2").Value = increase
        ws.Range("R3").Value = decrease
        ws.Range("R4").Value = volume
            'adjust cells syle to percentage
                ws.Range("R2", "R3").NumberFormat = "0.00%"
        
    Next ws
End Sub
