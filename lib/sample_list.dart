import 'package:flutter/foundation.dart';

import 'modules/calendar/agenda_view.dart';
import 'modules/calendar/airfare.dart';
import 'modules/calendar/appointment_editor.dart';
import 'modules/calendar/calendar_loadmore.dart';
import 'modules/calendar/customization.dart';
import 'modules/calendar/drag_and_drop_calendar.dart';
import 'modules/calendar/getting_started.dart';
import 'modules/calendar/heatmap.dart';
import 'modules/calendar/localization.dart';
import 'modules/calendar/recurrence.dart';
import 'modules/calendar/resizing_calendar.dart';
import 'modules/calendar/rtl.dart';
import 'modules/calendar/schedule_view.dart';
import 'modules/calendar/shift_scheduler.dart';
import 'modules/calendar/special_regions.dart';
import 'modules/calendar/timeline_views.dart';
import 'modules/chart/cartesian_charts/axis_features/axis_animation.dart';
import 'modules/chart/cartesian_charts/axis_features/axis_crossing.dart';
import 'modules/chart/cartesian_charts/axis_features/edge_label_placement.dart';
import 'modules/chart/cartesian_charts/axis_features/handling_label_collision.dart';
import 'modules/chart/cartesian_charts/axis_features/interval_type.dart';
import 'modules/chart/cartesian_charts/axis_features/maximum_width_for_labels.dart';
import 'modules/chart/cartesian_charts/axis_features/multi_level_labels.dart';
import 'modules/chart/cartesian_charts/axis_features/multiple_axis_chart.dart';
import 'modules/chart/cartesian_charts/axis_features/opposed_axes.dart';
import 'modules/chart/cartesian_charts/axis_features/plot_band.dart';
import 'modules/chart/cartesian_charts/axis_features/plot_band_recurrence.dart';
import 'modules/chart/cartesian_charts/axis_features/positioning_axis_label.dart';
import 'modules/chart/cartesian_charts/axis_types/category/default_category_axis.dart';
import 'modules/chart/cartesian_charts/axis_types/category/indexed_category_axis.dart';
import 'modules/chart/cartesian_charts/axis_types/category/label_placement.dart';
import 'modules/chart/cartesian_charts/axis_types/date_time/date_time_axis_with_label_format.dart';
import 'modules/chart/cartesian_charts/axis_types/date_time/default_date_time_axis.dart';
import 'modules/chart/cartesian_charts/axis_types/date_time_category/date_time_category_with_label_format.dart';
import 'modules/chart/cartesian_charts/axis_types/date_time_category/default_date_time_category.dart';
import 'modules/chart/cartesian_charts/axis_types/logarithmic/default_logarithmic_axis.dart';
import 'modules/chart/cartesian_charts/axis_types/logarithmic/inversed_logarithmic_axis.dart';
import 'modules/chart/cartesian_charts/axis_types/numeric/default_numeric_axis.dart';
import 'modules/chart/cartesian_charts/axis_types/numeric/inversed_numeric_axis.dart';
import 'modules/chart/cartesian_charts/axis_types/numeric/numeric_axis_with_label_format.dart';
import 'modules/chart/cartesian_charts/chart_types/area/animation_area_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/area/area_with_axis_base.dart';
import 'modules/chart/cartesian_charts/chart_types/area/area_with_emptypoints.dart';
import 'modules/chart/cartesian_charts/chart_types/area/area_zone.dart';
import 'modules/chart/cartesian_charts/chart_types/area/default_area_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/area/vertical_area_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/bar/animation_bar_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/bar/bar_width_and_spacing.dart';
import 'modules/chart/cartesian_charts/chart_types/bar/bar_with_rounded_corners.dart';
import 'modules/chart/cartesian_charts/chart_types/bar/bar_with_track.dart';
import 'modules/chart/cartesian_charts/chart_types/bar/customized_bar_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/bar/default_bar_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/box_whisker.dart';
import 'modules/chart/cartesian_charts/chart_types/bubble/animation_bubble_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/bubble/bubble_filled_with_gradient.dart';
import 'modules/chart/cartesian_charts/chart_types/bubble/bubble_with_multiple_series.dart';
import 'modules/chart/cartesian_charts/chart_types/bubble/bubble_with_various_colors.dart';
import 'modules/chart/cartesian_charts/chart_types/bubble/default_bubble_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/column/animation_column_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/column/back_to_back_column.dart';
import 'modules/chart/cartesian_charts/chart_types/column/column_width_and_spacing.dart';
import 'modules/chart/cartesian_charts/chart_types/column/column_with_axis_base.dart';
import 'modules/chart/cartesian_charts/chart_types/column/column_with_rounded_corners.dart';
import 'modules/chart/cartesian_charts/chart_types/column/column_with_track.dart';
import 'modules/chart/cartesian_charts/chart_types/column/customized_column_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/column/default_column_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/error_bar.dart';
import 'modules/chart/cartesian_charts/chart_types/financial_charts/candle_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/financial_charts/hilo_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/financial_charts/hilo_open_close_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/histogram.dart';
import 'modules/chart/cartesian_charts/chart_types/line/animation_line_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/line/customized_line_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/line/default_line_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/line/line_with_dashes.dart';
import 'modules/chart/cartesian_charts/chart_types/line/line_zone.dart';
import 'modules/chart/cartesian_charts/chart_types/line/multi_colored_line.dart';
import 'modules/chart/cartesian_charts/chart_types/range_area.dart';
import 'modules/chart/cartesian_charts/chart_types/range_column/animation_range_column_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/range_column/default_range_column_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/range_column/range_column_with_track.dart';
import 'modules/chart/cartesian_charts/chart_types/range_column/vertical_range_column_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/scatter/animation_scatter_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/scatter/default_scatter_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/scatter/scatter_with_various_shapes.dart';
import 'modules/chart/cartesian_charts/chart_types/spline/animation_spline_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/spline/customized_spline_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/spline/default_spline_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/spline/spline_types.dart';
import 'modules/chart/cartesian_charts/chart_types/spline/spline_with_dashes.dart';
import 'modules/chart/cartesian_charts/chart_types/spline/vertical_spline_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/spline_area.dart';
import 'modules/chart/cartesian_charts/chart_types/spline_range_area.dart';
import 'modules/chart/cartesian_charts/chart_types/stacked_100_charts/stacked_area_100_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/stacked_100_charts/stacked_bar_100_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/stacked_100_charts/stacked_column_100_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/stacked_100_charts/stacked_line_100_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/stacked_charts/stacked_area_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/stacked_charts/stacked_bar_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/stacked_charts/stacked_column_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/stacked_charts/stacked_line_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/step_area.dart';
import 'modules/chart/cartesian_charts/chart_types/step_line/animation_step_line_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/step_line/default_step_line_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/step_line/step_line_with_dashes.dart';
import 'modules/chart/cartesian_charts/chart_types/step_line/vertical_step_line_chart.dart';
import 'modules/chart/cartesian_charts/chart_types/waterfall/vertical_waterfall.dart';
import 'modules/chart/cartesian_charts/chart_types/waterfall/waterfall.dart';
import 'modules/chart/cartesian_charts/data_source/json.dart';
import 'modules/chart/cartesian_charts/data_source/list.dart';
import 'modules/chart/cartesian_charts/export.dart';
import 'modules/chart/cartesian_charts/legend/chart_with_customized_legend.dart';
import 'modules/chart/cartesian_charts/legend/legend_various_options.dart';
import 'modules/chart/cartesian_charts/series_features/animation/series_animation.dart';
import 'modules/chart/cartesian_charts/series_features/annotation/chart_with_annotation.dart';
import 'modules/chart/cartesian_charts/series_features/annotation/chart_with_watermark.dart';
import 'modules/chart/cartesian_charts/series_features/data_label/data_label_template.dart';
import 'modules/chart/cartesian_charts/series_features/data_label/default_data_labels.dart';
import 'modules/chart/cartesian_charts/series_features/empty_points.dart';
import 'modules/chart/cartesian_charts/series_features/gradients/gradient_based_on_values.dart';
import 'modules/chart/cartesian_charts/series_features/gradients/horizantal_gradient.dart';
import 'modules/chart/cartesian_charts/series_features/gradients/vertical_gradient.dart';
import 'modules/chart/cartesian_charts/series_features/marker.dart';
import 'modules/chart/cartesian_charts/series_features/point_color_mapper.dart';
import 'modules/chart/cartesian_charts/series_features/sorting.dart';
import 'modules/chart/cartesian_charts/technical_indicators/accumulation_distribution.dart';
import 'modules/chart/cartesian_charts/technical_indicators/atr_indicator.dart';
import 'modules/chart/cartesian_charts/technical_indicators/bollinger_indicator.dart';
import 'modules/chart/cartesian_charts/technical_indicators/ema_indicator.dart';
import 'modules/chart/cartesian_charts/technical_indicators/macd_indicator.dart';
import 'modules/chart/cartesian_charts/technical_indicators/momentum_indicator.dart';
import 'modules/chart/cartesian_charts/technical_indicators/rsi_indicator.dart';
import 'modules/chart/cartesian_charts/technical_indicators/sma_indicator.dart';
import 'modules/chart/cartesian_charts/technical_indicators/stochastic_indicator.dart';
import 'modules/chart/cartesian_charts/technical_indicators/tma_indicator.dart';
import 'modules/chart/cartesian_charts/trendline/default_trendline.dart';
import 'modules/chart/cartesian_charts/trendline/trendline_forecast.dart';
import 'modules/chart/cartesian_charts/user_interactions/add_point_on_click.dart';
import 'modules/chart/cartesian_charts/user_interactions/auto_scrolling.dart';
import 'modules/chart/cartesian_charts/user_interactions/crosshair.dart';
import 'modules/chart/cartesian_charts/user_interactions/events/data_point_events.dart';
import 'modules/chart/cartesian_charts/user_interactions/events/events.dart';
import 'modules/chart/cartesian_charts/user_interactions/events/navigation_with_events.dart';
import 'modules/chart/cartesian_charts/user_interactions/pagination.dart';
import 'modules/chart/cartesian_charts/user_interactions/selection/dynamic_selection.dart';
import 'modules/chart/cartesian_charts/user_interactions/selection/selection_modes.dart';
import 'modules/chart/cartesian_charts/user_interactions/tooltip/default_tooltip.dart';
import 'modules/chart/cartesian_charts/user_interactions/tooltip/tooltip_position.dart';
import 'modules/chart/cartesian_charts/user_interactions/tooltip/tooltip_template.dart';
import 'modules/chart/cartesian_charts/user_interactions/trackball/chart_with_trackball.dart';
import 'modules/chart/cartesian_charts/user_interactions/trackball/customized_trackball.dart';
import 'modules/chart/cartesian_charts/user_interactions/zooming_and_panning/pinch_zooming.dart';
import 'modules/chart/cartesian_charts/user_interactions/zooming_and_panning/selection_zooming.dart';
import 'modules/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_with_custom_buttons.dart';
import 'modules/chart/circular_charts/export.dart';
import 'modules/chart/circular_charts/legend/chart_with_legend.dart';
import 'modules/chart/circular_charts/legend/floating_legend.dart';
import 'modules/chart/circular_charts/legend/legend_with_various_options.dart';
import 'modules/chart/circular_charts/localization.dart';
import 'modules/chart/circular_charts/user_interactions/dynamic_selection.dart';
import 'modules/chart/circular_charts/user_interactions/selection.dart';
import 'modules/chart/circular_charts/user_interactions/tooltip.dart';
import 'modules/datagrid/apperance/conditional_styling/datagrid_conditional_styling.dart';
import 'modules/datagrid/apperance/styling/datagrid_styling.dart';
import 'modules/datagrid/columns/datagrid_checkbox_selection.dart';
import 'modules/datagrid/columns/datagrid_column_sizing.dart';
import 'modules/datagrid/columns/datagrid_column_types.dart';
import 'modules/datagrid/columns/datagrid_custom_header.dart';
import 'modules/datagrid/columns/datagrid_stacked_header.dart';
import 'modules/datagrid/data_source/datagrid_json_data_source.dart';
import 'modules/datagrid/data_source/datagrid_list_data_source.dart';
import 'modules/datagrid/datagrid_column_resizing.dart';
import 'modules/datagrid/datagrid_context_menu.dart';
import 'modules/datagrid/datagrid_editing.dart';
import 'modules/datagrid/datagrid_exporting.dart';
import 'modules/datagrid/datagrid_freeze_panes.dart';
import 'modules/datagrid/datagrid_getting_started.dart';
import 'modules/datagrid/datagrid_localization.dart';
import 'modules/datagrid/datagrid_paging.dart';
import 'modules/datagrid/datagrid_pull_to_refresh.dart';
import 'modules/datagrid/datagrid_real_time_update.dart';
import 'modules/datagrid/datagrid_row_height.dart';
import 'modules/datagrid/datagrid_rtl.dart';
import 'modules/datagrid/datagrid_selection.dart';
import 'modules/datagrid/datagrid_swiping.dart';
import 'modules/datagrid/datagrid_table_summary.dart';
import 'modules/datagrid/loadmore/datagrid_infinite_scrolling.dart';
import 'modules/datagrid/loadmore/datagrid_load_more.dart';
import 'modules/datagrid/sorting/datagrid_custom_sorting.dart';
import 'modules/datagrid/sorting/datagrid_sorting.dart';
import 'modules/date_picker/blackout_date_picker.dart';
import 'modules/date_picker/customized_date_picker.dart';
import 'modules/date_picker/date_picker_getting_started.dart';
import 'modules/date_picker/hijri_calendar.dart';
import 'modules/date_picker/localization.dart';
import 'modules/date_picker/popup_picker.dart';
import 'modules/date_picker/rtl.dart';
import 'modules/date_picker/vertical_calendar.dart';
import 'modules/files/file_upload.dart';
import 'modules/maps/directionality.dart';
import 'modules/maps/localization.dart';
import 'modules/maps/shape_layer/biodiversity/biodiversity.dart';
import 'modules/maps/shape_layer/bubble/bubble.dart';
import 'modules/maps/shape_layer/equal_color_mapping/equal_color_mapping.dart';
import 'modules/maps/shape_layer/legend/legend.dart';
import 'modules/maps/shape_layer/marker/marker.dart';
import 'modules/maps/shape_layer/range_color_mapping/range_color_mapping.dart';
import 'modules/maps/shape_layer/selection/selection.dart';
import 'modules/maps/shape_layer/sublayer/sublayer.dart';
import 'modules/maps/shape_layer/tooltip/tooltip.dart';
import 'modules/maps/shape_layer/zooming/zooming.dart';
import 'modules/maps/tile_layer/bing_map/bing_map.dart';
import 'modules/maps/tile_layer/crosshair/crosshair.dart';
import 'modules/maps/tile_layer/open_street_map/open_street_map.dart';
import 'modules/maps/tile_layer/vector_layer/arcs.dart';
import 'modules/maps/tile_layer/vector_layer/lcc.dart';
import 'modules/maps/tile_layer/vector_layer/lulc.dart';
import 'modules/maps/tile_layer/vector_layer/polylines.dart';

/// Contains the output widget of sample
/// appropriate key and output widget mapped
Map<String, Function> getSampleWidget() {
  return <String, Function>{
    // cartesian charts
    'default_line_chart': (Key key) => LineDefault(key),
    'line_with_dashes': (Key key) => LineDashed(key),
    'multi_colored_line': (Key key) => LineMultiColor(key),
    'customized_line_chart': (Key key) => CustomizedLine(key),
    'animation_line_chart': (Key key) => AnimationLineDefault(key),
    'line_shader': (Key key) => LineZone(key),
    'area_shader': (Key key) => AreaZone(key),
    'gradient_comparison': (Key key) => GradientComparison(key),
    'histogram_chart': (Key key) => HistogramDefault(key),
    'spline_range_area': (Key key) => SplineRangeArea(key),
    'default_column_chart': (Key key) => ColumnDefault(key),
    'point_color_mapper': (Key key) => PointColorMapper(key),
    'column_with_rounded_corners': (Key key) => ColumnRounded(key),
    'back_to_back_column': (Key key) => ColumnBack(key),
    'column_with_track': (Key key) => ColumnTracker(key),
    'column_width_and_spacing': (Key key) => ColumnSpacing(key),
    'customized_column_chart': (Key key) => ColumnVertical(key),
    'column_axis_crossing': (Key key) => ColumnAxisCrossingBaseValue(key),
    'animation_column_chart': (Key key) => AnimationColumnDefault(key),
    'default_spline_chart': (Key key) => SplineDefault(key),
    'spline_with_dashes': (Key key) => SplineDashed(key),
    'spline_types': (Key key) => SplineTypes(key),
    'vertical_spline_chart': (Key key) => SplineVertical(key),
    'customized_spline_chart': (Key key) => SplineCustomization(key),
    'animation_spline_chart': (Key key) => AnimationSplineDefault(key),
    'default_area_chart': (Key key) => AreaDefault(key),
    'area_with_emptypoints': (Key key) => AreaEmpty(key),
    'vertical_area_chart': (Key key) => AreaVertical(key),
    'area_axis_crossing': (Key key) => AreaAxisCrossingBaseValue(key),
    'animation_area_chart': (Key key) => AnimationAreaDefault(key),
    'range_area': (Key key) => RangeArea(key),
    'step_area': (Key key) => StepArea(key),
    'spline_area': (Key key) => SplineArea(key),
    'default_bar_chart': (Key key) => BarDefault(key),
    'bar_with_rounded_corners': (Key key) => BarRounded(key),
    'bar_width_and_spacing': (Key key) => BarSpacing(key),
    'bar_with_track': (Key key) => BarTracker(key),
    'customized_bar_chart': (Key key) => BarCustomization(key),
    'animation_bar_chart': (Key key) => AnimationBarDefault(key),
    'default_bubble_chart': (Key key) => BubbleDefault(key),
    'bubble_with_various_colors': (Key key) => BubblePointColor(key),
    'bubble_filled_with_gradient': (Key key) => BubbleGradient(key),
    'bubble_with_multiple_series': (Key key) => BubbleMultiSeries(key),
    'animation_bubble_chart': (Key key) => AnimationBubbleDefault(key),
    'default_scatter_chart': (Key key) => ScatterDefault(key),
    'scatter_with_various_shapes': (Key key) => ScatterShapes(key),
    'animation_scatter_chart': (Key key) => AnimationScatterDefault(key),
    'default_stepline_chart': (Key key) => StepLineDefault(key),
    'stepline_with_dashes': (Key key) => StepLineDashed(key),
    'vertical_stepline_chart': (Key key) => StepLineVertical(key),
    'animation_stepline_chart': (Key key) => AnimationStepLineDefault(key),
    'default_rangecolumn_chart': (Key key) => RangeColumnDefault(key),
    'vertical_rangecolumn_chart': (Key key) => RangeBarChart(key),
    'rangecolumn_with_track': (Key key) => RangeColumnWithTrack(key),
    'animation_rangecolumn_chart': (Key key) =>
        AnimationRangeColumnDefault(key),
    'stacked_line_chart': (Key key) => StackedLineChart(key),
    'stacked_area_chart': (Key key) => StackedAreaChart(key),
    'stacked_column_chart': (Key key) => StackedColumnChart(key),
    'stacked_bar_chart': (Key key) => StackedBarChart(key),
    'stacked_area_100_chart': (Key key) => StackedArea100Chart(key),
    'stacked_bar_100_chart': (Key key) => StackedBar100Chart(key),
    'stacked_column_100_chart': (Key key) => StackedColumn100Chart(key),
    'stacked_line_100_chart': (Key key) => StackedLine100Chart(key),
    'default_numeric_axis': (Key key) => NumericDefault(key),
    'numeric_axis_with_label_format': (Key key) => NumericLabel(key),
    'inversed_numeric_axis': (Key key) => NumericInverse(key),
    'default_category_axis': (Key key) => CategoryDefault(key),
    'category_arranged_by_index': (Key key) => CategoryIndexed(key),
    'category_label_placement': (Key key) => CategoryTicks(key),
    'default_datetime_axis': (Key key) => DateTimeDefault(key),
    'datetime_axis_with_label_format': (Key key) => DateTimeLabel(key),
    'default_datetime_category_axis': (Key key) => DateTimeCategoryDefault(key),
    'default_datetime_category_axis_label': (Key key) =>
        DateTimeCategoryLabel(key),
    'default_logarithmic_axis': (Key key) => LogarithmicAxisDefault(key),
    'inversed_logarithmic_axis': (Key key) => LogarithmicAxisInversed(key),
    'hilo_chart': (Key key) => HiloChart(key),
    'hilo_open_close_chart': (Key key) => HiloOpenCloseChart(key),
    'candle_chart': (Key key) => CandleChart(key),
    'axis_crossing': (Key key) => AxisCrossing(key),
    'positioning_axis_labels': (Key key) => LabelCustomization(key),
    'axis_animation': (Key key) => AxisAnimationDefault(key),
    'edgelabel_placement': (Key key) => EdgeLabel(key),
    'chart_maximum_label_width': (Key key) => ChartMaximumLabelWidth(key),
    'interval_type': (Key key) => IntervalType(key),
    'handling_label_collision': (Key key) => LabelAction(key),
    'multiple_axis_chart': (Key key) => MultipleAxis(key),
    'multi_level_labels': (Key key) => MultiLevelLabelsSample(key),
    'opposed_axes': (Key key) => NumericOpposed(key),
    'plot_band_recurrence': (Key key) => PlotBandRecurrence(key),
    'plot_band': (Key key) => PlotBandDefault(key),
    'box_whisker': (Key key) => BoxWhisker(key),
    'water_fall': (Key key) => WaterFall(key),
    'vertical_water_fall': (Key key) => VerticalWaterFall(key),
    'error_bar': (Key key) => ErrorBarDefault(key),

    //Series Features
    'series_animation': (Key key) => AnimationDefault(key),
    'chart_with_annotation': (Key key) => AnnotationWatermark(key),
    'chart_with_watermark': (Key key) => AnnotationDefault(key),
    'default_datalabels': (Key key) => DataLabelDefault(key),
    'datalabel_template': (Key key) => DataLabelTemplate(key),
    'chart_with_empty_points': (Key key) => EmptyPoints(key),
    'horizantal_gradient': (Key key) => HorizantalGradient(key),
    'vertical_gradient': (Key key) => VerticalGradient(key),
    'various_marker_shapes': (Key key) => MarkerDefault(key),
    'sorting_options': (Key key) => SortingDefault(key),
    'default_trendlines_with_options': (Key key) => TrendLineDefault(key),
    'trendline_forecast_with_options': (Key key) => TrendLineForecast(key),

    //Legend
    'chart_with_customized_legend': (Key key) => LegendCustomized(key),
    'chart_with_legend': (Key key) => LegendDefault(key),
    'legend_with_various_options': (Key key) => LegendOptions(key),
    'cartesian_legend_various_options': (Key key) =>
        CartesianLegendOptions(key),
    'circular_floating_legend': (Key key) => CircularFloatingLegend(key),

    //Technical Indicators
    'accumulation_distribution': (Key key) => AdIndicator(key),
    'atr_indicator': (Key key) => ATRIndicator(key),
    'bollinger_indicator': (Key key) => BollingerIndicator(key),
    'ema_indicator': (Key key) => EMAIndicator(key),
    'momentum_indicator': (Key key) => MomentummIndicator(key),
    'rsi_indicator': (Key key) => RSIIndicator(key),
    'sma_indicator': (Key key) => SMAIndicator(key),
    'stochastic_indicator': (Key key) => StochasticcIndicator(key),
    'tma_indicator': (Key key) => TMAIndicator(key),
    'macd_indicator': (Key key) => MACDIndicator(key),

    //User Interaction
    'chart_with_crosshair': (Key key) => DefaultCrossHair(key),
    'selection_modes': (Key key) => DefaultSelection(key),
    'selection_index': (Key key) => SelectionIndex(key),
    'default_tooltip': (Key key) => DefaultTooltip(key),
    'chart_with_trackball': (Key key) => DefaultTrackball(key),
    'chart_with_trackball_template': (Key key) => TrackballTemplate(key),
    'pinch_zooming': (Key key) => DefaultPanning(key),
    'selection_zooming': (Key key) => DefaultZooming(key),
    'zooming_with_custom_buttons': (Key key) => ButtonZooming(key),
    'tooltip_position': (Key key) => CartesianTooltipPosition(key),
    'tooltip_template': (Key key) => TooltipTemplate(key),
    'circular_selection': (Key key) => CircularSelection(key),
    'circular_dynamic_selection': (Key key) => DynamicCircularSelection(key),
    'circular_localization': (Key key) => LocalizationCircularChart(key),
    'pie_tooltip_position': (Key key) => PieTooltipPosition(key),
    'events': (Key key) => Events(key),
    'data_points': (Key key) => DataPoints(key),
    'navigate_with_events': (Key key) => NavigationWithEvents(key),
    'chart_interactivity': (Key key) => InteractiveChart(key),
    'pagination': (Key key) => Pagination(key),
    'auto_scrolling': (Key key) => AutoScrollingChart(key),

    //Exporting
    'exporting_chart': (Key key) => Export(key),
    'export_circular_chart': (Key key) => ExportCircular(key),

    //Data binding
    'local_list_data': (Key key) => LocalData(key),
    'local_json_data': (Key key) => JsonData(key),

    // Calendar Samples
    'getting_started_calendar': (Key key) => GettingStartedCalendar(key),
    'recurrence_calendar': (Key key) => RecurrenceCalendar(key),
    'agenda_view_calendar': (Key key) => AgendaViewCalendar(key),
    'appointment_editor_calendar': (Key key) => CalendarAppointmentEditor(key),
    'customization_calendar': (Key key) => CustomizationCalendar(key),
    'special_regions_calendar': (Key key) => SpecialRegionsCalendar(key),
    'schedule_view_calendar': (Key key) => ScheduleViewCalendar(key),
    'shift_scheduler': (Key key) => ShiftScheduler(key),
    'timeline_views_calendar': (Key key) => TimelineViewsCalendar(key),
    'heat_map_calendar': (Key key) => HeatMapCalendar(key),
    'air_fare_calendar': (Key key) => AirFareCalendar(key),
    'loadmore_calendar': (Key key) => LoadMoreCalendar(key),
    'drag_and_drop_calendar': (Key key) => DragAndDropCalendar(key),
    'resizing_calendar': (Key key) => ResizingCalendar(key),
    'rtl_calendar': (Key key) => CalendarRtl(key),
    'localization_calendar': (Key key) => CalendarLocalization(key),

    // Date picker Samples
    'getting_started_date_picker': (Key key) => GettingStartedDatePicker(key),
    'hijri_calendar_date_picker': (Key key) => HijriDatePicker(key),
    'blackout_picker': (Key key) => BlackoutDatePicker(key),
    'customized_picker': (Key key) => CustomizedDatePicker(key),
    'popup_picker': (Key key) => PopUpDatePicker(key),
    'vertical_calendar': (Key key) => VerticalCalendar(key),
    'rtl_date_picker': (Key key) => RtlDatePicker(key),
    'localization_picker': (Key key) => PickerLocalization(key),

    //dataGridSample
    'getting_started_datagrid': (Key key) => GettingStartedDataGrid(key: key),

    'column_types_datagrid': (Key key) => ColumnTypeDataGrid(key: key),

    'editing_datagrid': (Key key) => EditingDataGrid(key: key),

    'custom_header_datagrid': (Key key) => CustomHeaderDataGrid(key: key),

    'column_sizing_datagrid': (Key key) => ColumnSizingDataGrid(key: key),

    'selection_datagrid': (Key key) => SelectionDataGrid(key: key),

    'styling_datagrid': (Key key) => StylingDataGrid(key: key),

    'row_height_datagrid': (Key key) => RowHeightDataGrid(key: key),

    'conditional_styling_datagrid': (Key key) =>
        ConditionalStylingDataGrid(key: key),

    'paging_datagrid': (Key key) => PagingDataGrid(key: key),

    'real_time_update_datagrid': (Key key) => RealTimeUpdateDataGrid(key: key),

    'json_data_source_datagrid': (Key key) => JsonDataSourceDataGrid(key: key),

    'list_data_source_datagrid': (Key key) => ListDataSourceDataGrid(key: key),

    'column_resizing_datagrid': (Key key) => ColumnResizingDataGrid(key: key),

    'freeze_panes_datagrid': (Key key) => FreezePanesDataGrid(key: key),

    'sorting_datagrid': (Key key) => SortingDataGrid(key: key),
    'custom_sorting_datagrid': (Key key) => CustomSortingDataGrid(key: key),

    'stacked_header_datagrid': (Key key) => StackedHeaderDataGrid(key: key),

    'load_more_infinite_scrolling_datagrid': (Key key) =>
        LoadMoreInfiniteScrollingDataGrid(key: key),

    'load_more_datagrid': (Key key) => LoadMoreDataGrid(key: key),

    'pull_to_refresh_datagrid': (Key key) => PullToRefreshDataGrid(key: key),

    'context_menu_datagrid': (Key key) => ContextMenuDataGrid(
          key: key,
        ),

    'swiping_datagrid': (Key key) => SwipingDataGrid(key: key),

    'checkbox_selection_datagrid': (Key key) =>
        CheckboxSelectionDataGrid(key: key),

    'table_summary_datagrid': (Key key) => TableSummaryDataGrid(key: key),

    'exporting_datagrid': (Key key) => ExportingDataGrid(key: key),

    'rtl_datagrid': (Key key) => RTLModeDataGrid(key: key),

    'localization_paging_datagrid': (Key key) => LocalizationDataGrid(key: key),

    // Maps: Shape Layer Samples
    'range_color_mapping': (Key key) => MapRangeColorMappingPage(key),

    'equal_color_mapping': (Key key) => MapEqualColorMappingPage(key),

    'bubble': (Key key) => MapBubblePage(key),

    'selection': (Key key) => MapSelectionPage(key),

    'marker': (Key key) => MapMarkerPage(key),

    'legend': (Key key) => MapLegendPage(key),

    'tooltip': (Key key) => MapTooltipPage(key),

    'biodiversity': (Key key) => MapBioDiversityPage(key),

    'studyArea': (Key key) => MapZoomingPage(key),

    'sublayer': (Key key) => MapSublayerPage(key),

    'maps_with_directionality': (Key key) => MapsWithDirectionality(key),

    'maps_with_localization': (Key key) => MapsWithLocalization(key),

    // Maps: Tile Layer Samples
    'open_street_map': (Key key) => MapOSMPage(key),

    'bing_map': (Key key) => MapBingPage(key),

    'crosshair': (Key key) => MapCrosshairPage(key),

    'arcs': (Key key) => MapArcsPage(key),

    'polylines': (Key key) => MapPolylinesPage(key),

    'lulc': (Key key) => MapLULCPage(key),

    'lcc': (Key key) => MapLCCPage(key),

    'fileUpload': (Key key) => FileUploadPage(key: key),
  };
}
