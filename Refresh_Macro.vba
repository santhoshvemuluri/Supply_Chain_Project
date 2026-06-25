' ====================================================================
' Excel VBA Macro: Dashboard Automation
' Purpose: Refreshes all data connections (SQL to Excel), updates all 
' Pivot Tables, and clears Slicer filters for a clean dashboard view.
' ====================================================================

Sub RefreshDashboardData()
    Dim ws As Worksheet
    Dim pt As PivotTable
    Dim slC As SlicerCache
    
    ' Disable screen updating to make the macro run faster and look cleaner
    Application.ScreenUpdating = False
    
    ' Step 1: Refresh all external data connections (SQL/CSV imports)
    ActiveWorkbook.RefreshAll
    
    ' Step 2: Loop through all worksheets and refresh all Pivot Tables
    For Each ws In ThisWorkbook.Worksheets
        For Each pt In ws.PivotTables
            pt.RefreshTable
        Next pt
    Next ws
    
    ' Step 3: Clear all Slicer filters to reset the dashboard view
    On Error Resume Next ' Prevent error if a slicer is already empty
    For Each slC In ActiveWorkbook.SlicerCaches
        slC.ClearManualFilter
    Next slC
    On Error GoTo 0
    
    ' Re-enable screen updating
    Application.ScreenUpdating = True
    
    ' Notify the user
    MsgBox "Logistics KPIs and Dashboard Data have been successfully updated!", vbInformation, "Update Complete"
    
End Sub
