
//특수진료
const List<String> special = ['소아야간진료(20시 이후)','한방척추질환','측두하악관절 자극요법','응급의료병원','성인·소아 중환자실','개방병원',
  '혈액투석','체외충격파쇄석술','인공심박동기이식술','알코올질환입원치료병원','신장이식술','정맥류수술','간이식술','의료서비스지원사업기관','신생아 중환자실',
  '제왕절개후자연분만병원','안와골절정복술','부정맥고주파절제술','가정간호실시병원','사시수술','인공와우이식술','심율동전환제세동기거치술','망막수술','각막이식술',
  '완화의료전문기관','공막이식술','골수이식술','제3차 의료급여기관','심장이식술','자궁 및 자궁부속기(난소, 난관 등) 수술','구순구개열','제왕절개분만',
  '관절','보훈위탁병원','안과','화상치료병원','외과','화상','척추','대장항문','손·발가락 접합술','수지접합','유방','알코올','폐이식술','심장질환','산부인과',
  '관절+수지접합','이비인후과','뇌혈관','췌장이식술','한방중풍질환','주산기(모자)','소장이식술','소아청소년과'];
//일반진료
const List<String> normal = ['내과','신경과','정신건강의학과','외과','정형외과','신경외과','흉부외과','성형외과','마취통증의학과','산부인과',
  '소아청소년과','안과','이비인후과','피부과','비뇨의학과','비뇨기과','영상의학과','방사선종양학과','병리과','진단검사의학과','결핵과','재활의학과',
  '핵의학과','가정의학과','응급의학과','직업환경의학과','예방의학과','치과','구강악안면외과','치과보철과','치과교정과','소아치과','치주과','치과보존과',
  '구강내과','영상치의학과','구강악안면방사선과','구강병리과','예방치과','통합치의학과','한방내과','한방부인과','한방소아과','한방안·이비인후·피부과',
  '한방안이비인후피부과','한방신경정신과','침구과','한방재활의학과','사상체질과','한방응급'];

//질병정보 구조체
class Disease{
  dynamic type;
  dynamic name;

  Disease(var name, var type)
  {
    this.type = type;
    this.name = name;
  }
}