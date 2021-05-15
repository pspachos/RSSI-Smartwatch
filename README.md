# rss_smartwatch

This dataset was collected for the purpose to understand the proximity between any two smartwatches worn by human.
We used the Google's Wear OS based smartwatch, powered by a Qualcomm Snapdragon Wear 3100 processor, from Fossil sport to collect the data.
The smartwatch is powered by a Qualcomm Snapdragon Wear 3100 processor and has an internal memory of up to 1GB.

<p align="center">
  <img alt="Smartphones carried by users on different body positions" 
       width="500" height="200"
       src="/figure/watch data collection illustration.png" />
</p>

Two volunteers were required to wear the smartwatch on different hand and stand at a certain distance from each other.
The direct data refers to the dataset collected when one volunteer wore the smartwatch on the left hand and the other on the right hand; 
whereas the crosswise data refers to the dataset collected when both volunteers wore the smartwatch on the same hand.
Both smartwatches log the following information:
<ul>
  <li>the truth distance,</li>
  <li>name of the smartphone,</li>
  <li>MAC address of BLE chipset,</li>
  <li>the packet payload,</li>
  <li>RSS values,</li>
  <li>time elapsed, and</li>
  <li>timestamp </li>
</ul>
These raw data was exported to Matlab and reorganized into training and testing data.

Specifically, we organize the training and testing dataset by excluding unnecessary information, while grouping the number of samples received when the two volunteers are at certain distance from each other.
The final dataset consists the following information:
<ul>
  <li>the source of the data, i.e., either 31 or 26 (this number is taken based on the last hex value of the smartwatches's mac address  </li>
  <li>combination, i.e., RR, LL, RL, LR (indicating the position of smartwatch on left or right hand)</li>
  <li>risk</li>
  <li>True distance</li>
  <li>Number of samples</li>
  <li>mean RSS</li>
  <li>max RSS</li>
  <li>min RSS</li>
  <li>The range of RSS</li>
</ul>

# Paper
Refer to the following paper for more information.

P. C. Ng, P. Spachos, S. Gregory and K. N. Plataniotis, "Epidemic Exposure Notification with Smartwatch: A Proximity-Based Privacy-Preserving Approach," in IEEE Internet of Things Journal, vol. x, no. x, pp. xx-xx, 2020 (submitted).

Preprint: https://arxiv.org/abs/2007.04399
