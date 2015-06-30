module Saq::IndexHelper
  #表头
  def table_header opts=[]
    ths=""

    opts.each do |x|
      ths += %Q{
    <th>#{x}</th>
    }
    end

    (%Q{
     <thead>
      <tr>} +
          ths+
      %Q{
      </tr>
    </thead>
    }).html_safe
  end

  #表中单行
  def table_row opts=[]
    tds = ''
    opts.each do |x|
      tds += %Q{
    <td>#{x}</td>
    }
    end

    (%Q{<tr>}+
        tds +
        %Q{</tr>}
    ).html_safe


  end

  #表中多行
  def table_multiple_row opts=[]

  end


end