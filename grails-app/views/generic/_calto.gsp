<!-- 
/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */
-->
<div id="calcul">
  <script type="text/javascript">
                  calc_array = new Array();
                  var calcul=0;
                  var pas_ch=0;
                  function $id(id)
                  {
                          return document.getElementById(id);
                  }
                  function f_calc(id,n)
                  {
                          if(n=='ce')
                          {
                                  initialiser_calc(id);
                          }
                          else if(n=='=')
                          {
                                  if(calc_array[id][0]!='=' && calc_array[id][1]!=1)
                                  {
                                          eval('calcul='+calc_array[id][2]+calc_array[id][0]+calc_array[id][3]+';');
                                          calc_array[id][0] = '=';
                                          $id(id+'_resultat').value=calcul;
                                          calc_array[id][2]=calcul;
                                          calc_array[id][3]=0;
                                  }
                          }
                          else if(n=='+-')
                          {
                                  $id(id+'_resultat').value=$id(id+'_resultat').value*(-1);
                                  if(calc_array[id][0]=='=')
                                  {
                                          calc_array[id][2] = $id(id+'_resultat').value;
                                          calc_array[id][3] = 0;
                                  }
                                  else
                                  {
                                          calc_array[id][3] = $id(id+'_resultat').value;
                                  }
                                  pas_ch = 1;
                          }
                          else if(n=='nbs')
                          {
                                  if($id(id+'_resultat').value<10 && $id(id+'_resultat').value>-10)
                                  {
                                          $id(id+'_resultat').value=0;
                                  }
                                  else
                                  {
                                          $id(id+'_resultat').value=$id(id+'_resultat').value.slice(0,$id(id+'_resultat').value.length-1);
                                  }
                                  if(calc_array[id][0]=='=')
                                  {
                                          calc_array[id][2] = $id(id+'_resultat').value;
                                          calc_array[id][3] = 0;
                                  }
                                  else
                                  {
                                          calc_array[id][3] = $id(id+'_resultat').value;
                                  }
                          }
                          else
                          {
                                          if(calc_array[id][0]!='=' && calc_array[id][1]!=1)
                                          {
                                                  eval('calcul='+calc_array[id][2]+calc_array[id][0]+calc_array[id][3]+';');
                                                  $id(id+'_resultat').value=calcul;
                                                  calc_array[id][2]=calcul;
                                                  calc_array[id][3]=0;
                                          }
                                          calc_array[id][0] = n;
                          }
                          if(pas_ch==0)
                          {
                                  calc_array[id][1] = 1;
                          }
                          else
                          {
                                  pas_ch=0;
                          }
                          document.getElementById(id+'_resultat').focus();
                          return true;
                  }
                  function add_calc(id,n)
                  {
                          if(calc_array[id][1]==1)
                          {
                                  $id(id+'_resultat').value=n;
                          }
                          else
                          {
                                  $id(id+'_resultat').value+=n;
                          }
                          if(calc_array[id][0]=='=')
                          {
                                  calc_array[id][2] = $id(id+'_resultat').value;
                                  calc_array[id][3] = 0;
                          }
                          else
                          {
                                  calc_array[id][3] = $id(id+'_resultat').value;
                          }
                          calc_array[id][1] = 0;
                          document.getElementById(id+'_resultat').focus();
                          return true;
                  }
                  function initialiser_calc(id)
                  {
                          $id(id+'_resultat').value=0;
                          calc_array[id] = new Array('=',1,'0','0',0);
                          document.getElementById(id+'_resultat').focus();
                          return true;
                  }
                  function key_detect_calc(id,evt)
                  {
                          if((evt.keyCode>95) && (evt.keyCode<106))
                          {
                                  var nbr = evt.keyCode-96;
                                  add_calc(id,nbr);
                          }
                          else if((evt.keyCode>47) && (evt.keyCode<58))
                          {
                                  var nbr = evt.keyCode-48;
                                  add_calc(id,nbr);
                          }
                          else if(evt.keyCode==107)
                          {
                                  f_calc(id,'+');
                          }
                          else if(evt.keyCode==109)
                          {
                                  f_calc(id,'-');
                          }
                          else if(evt.keyCode==106)
                          {
                                  f_calc(id,'*');
                          }
                          else if(evt.keyCode==111)
                          {
                                          f_calc(id,'/');
                          }
                          else if(evt.keyCode==110)
                          {
                                  add_calc(id,'.');
                          }
                          else if(evt.keyCode==190)
                          {
                                  add_calc(id,'.');
                          }
                          else if(evt.keyCode==188)
                          {
                                  add_calc(id,'.');
                          }
                          else if(evt.keyCode==13)
                          {
                                  f_calc(id,'=');
                          }
                          else if(evt.keyCode==46)
                          {
                                  f_calc(id,'ce');
                          }
                          else if(evt.keyCode==8)
                          {
                                  f_calc(id,'nbs');
                          }
                          else if(evt.keyCode==27)
                          {
                                  f_calc(id,'ce');
                          }
                          return true;
                  }
  </script>
  <style type="text/css">
  .calculatrice
  {
    background-color:#eeeeee;
    border:2px solid #92E07F;
/*    margin:auto;*/
    opacity: 0.8;
  }
  .calculatrice td
  {
    /*    height:16.66%;*/
  }
  .calc_td_resultat
  {
    text-align:center;
  }
  .calc_resultat
  {
    /*    width:90%;*/
    text-align:right;
  }
  .calc_td_calculs
  {
    text-align:center;
  }
  .calc_calculs
  {
    /*    width:90%;*/
    text-align:left;
  }
  .calc_td_btn
  {
    /*    width:25%;*/
    /*    height:100%;*/
  }
  .calc_btn
  {
    width:25px;
    /*    height:90%;*/
    /*    font-size:20px;*/
  }
  </style>
  <table class="calculatrice" id="calc">
    <tr>
      <td colspan="4" class="calc_td_resultat">
        <input type="text" readonly="readonly" name="calc_resultat" id="calc_resultat" class="calc_resultat" onkeydown="javascript:key_detect_calc('calc',event);" />
      </td>
    </tr>
    <tr>
      <td class="calc_td_btn">

        <input type="button" class="calc_btn" value="CE" onclick="javascript:f_calc('calc','ce');" />
      </td>
      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="&larr;" onclick="javascript:f_calc('calc','nbs');" />
      </td>
      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="%" onclick="javascript:f_calc('calc','%');" />
      </td>
      <td class="calc_td_btn">

        <input type="button" class="calc_btn" value="+" onclick="javascript:f_calc('calc','+');" />
      </td>
    </tr>
    <tr>
      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="7" onclick="javascript:add_calc('calc',7);" />
      </td>
      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="8" onclick="javascript:add_calc('calc',8);" />

      </td>
      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="9" onclick="javascript:add_calc('calc',9);" />
      </td>
      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="-" onclick="javascript:f_calc('calc','-');" />
      </td>
    </tr>
    <tr>

      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="4" onclick="javascript:add_calc('calc',4);" />
      </td>
      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="5" onclick="javascript:add_calc('calc',5);" />
      </td>
      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="6" onclick="javascript:add_calc('calc',6);" />
      </td>

      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="x" onclick="javascript:f_calc('calc','*');" />
      </td>
    </tr>
    <tr>
      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="1" onclick="javascript:add_calc('calc',1);" />
      </td>
      <td class="calc_td_btn">

        <input type="button" class="calc_btn" value="2" onclick="javascript:add_calc('calc',2);" />
      </td>
      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="3" onclick="javascript:add_calc('calc',3);" />
      </td>
      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="&divide;" onclick="javascript:f_calc('calc','/');" />
      </td>
    </tr>

    <tr>
      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="0" onclick="javascript:add_calc('calc',0);" />
      </td>
      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="&plusmn;" onclick="javascript:f_calc('calc','+-');" />
      </td>
      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="," onclick="javascript:add_calc('calc','.');" />

      </td>
      <td class="calc_td_btn">
        <input type="button" class="calc_btn" value="=" onclick="javascript:f_calc('calc','=');" />
      </td>
    </tr>
  </table>
  <script type="text/javascript">
                  document.getElementById('calc').onload=initialiser_calc('calc');
  </script>
</div>