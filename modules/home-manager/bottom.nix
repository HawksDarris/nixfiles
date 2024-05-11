{ config, ... }: 

{
  programs.bottom = with config.colorScheme.palette; {
    enable = true;
    settings = {
      colors = {
      # [colors] 
      # Represents the colour of table headers (processes, CPU, disks, temperature).
      table_header_color = "#${base0C}";
      widget_title_color = "#${base04}";
      avg_cpu_color = "#${base0F}";
      cpu_core_colors = ["#${base0E}" "#${base0A}" "#${base05}" "#${base0B}" "#${base0C}" "#${base09}" "#${base07}" "Green" "#${base0D}" "#${base0F}"];
      ram_color="#${base0E}";
      swap_color="#${base0A}";
      arc_color="#${base05}";
      gpu_core_colors=["#${base0B}" "#${base0C}" "#${base09}" "#${base07}" "Green" "#${base0D}" "#${base0F}"];
      rx_color="#${base05}";
      tx_color="#${base0B}";
      border_color="#${base04}";
      highlighted_border_color="#${base0C}";
      text_color="#${base04}";
      selected_text_color="#${base00}";
      selected_bg_color="#${base0C}";
      graph_color="#${base04}";
      high_battery_color="green";
      medium_battery_color="yellow";
      low_battery_color="#${base08}";
    };
  };
};
}
