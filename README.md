# flexible_calendar

Flexible Calendar widget that makes custom a Calendar much easier! Based on the StatefulWidget, this widget works on both Android & iOS.

https://pub.dev/packages/flexible_calendar

# Installing
Add the following to your `pubspec.yaml` file:

``` diff
dependencies: 
  flexible_calendar: 1.0.0
  ```
  
# Simple Usage

After implement, you just use it like a normal child widget.
Like this

![alt](https://user-images.githubusercontent.com/78459285/126870689-21bb11d2-b1d8-4106-8059-261a709641f2.png)

## Screenshots

Choose a date

<img width="300" alt="Screen Shot 2021-07-24 at 20 56 31" src="https://user-images.githubusercontent.com/78459285/126870806-459e7b43-0e36-4ce3-8b02-7a4a2157b7f6.png">

Select date range

<img width="300" alt="Screen Shot 2021-07-24 at 20 56 31" src="https://user-images.githubusercontent.com/78459285/126870812-d16239aa-32a7-49c9-8df5-cd62de0f69eb.png">

# Custom Usage

There are several options that allow for more control:

Properties | Description
------------ | -------------
```initialStartDate``` | Initialize the start date of the calendar, you need to update it every time you select a date in the calendar.
```initialEndDate``` | Initialize the start date of the calendar. If use selection mode to select only one date, you can set ```initialEndDate = null```.
```startEndDateChange``` | Every time you click on the date, it will jump into this function for you to update the variable.
```minimumDate``` | Limit minimum date can choose.
```maximumDate``` | Limit maximum date can choose.
```isConvertDateOfWeekToVietnamese``` | Default date of week is "Mon, Tue, ...", please set **true** if you like it show "T2, T3, T4, ..."
```formatMonthTitle``` | Format title show top of calendar. Example: DateFormat("MM, yyyy") will show ```07, 2021```
```textPreMonthTitle``` | Set text pre title. Example: ```                      textPreMonthTitle: "Month", ``` will show ```Month 07, 2021```
```decorationOfSelectedDay``` | You can custom decoration of selected widget to suil design.
```colorOfDayInMonth``` | Set color of date in current month.
```colorDayInAnotherMonth``` | Set color of date in anothe month.
```colorOfSelectedDay``` | Set color of selected date.
```styleOfDay``` | Common style of all dates in the calendar.
```isSelectedOnlyOneDay``` | Enable mode select a date, default is select range.
```colorInRange``` | Set backgroundColor of range date, not contains StartDate and EndDate.







