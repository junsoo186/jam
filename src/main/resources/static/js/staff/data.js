
// 프로젝트 데이터를 반환하는 함수
function getProjectData() {
    return {
        1: {
            name: "업무자동화 프로젝트",
            creator: "박민수",
            period: "2023-06-28 ~ 2023-08-10",
            goal: "80%",
            budget: "₩1,500,000",
            company: "레드트리 팀",
            contact: "박태영, 010-1111-2222",
            note: "말일에 제작 재확정 예정입니다. 업체 담당자에게 연락 부탁드립니다."
        },
        2: {
            name: "디자인 리뉴얼 프로젝트",
            creator: "이수진",
            period: "2023-07-01 ~ 2023-08-20",
            goal: "55%",
            budget: "₩800,000",
            company: "블루트리 팀",
            contact: "김영희, 010-2222-3333",
            note: "프로젝트 관련 사항 협의 중."
        }
    };
}

// 콘텐츠 데이터를 반환하는 함수
function getContentData() {
    return {
        1: {
            name: "어벤져스 대작",
            age: "전체이용가",
            creator: "김사자",
            period: "2024-08-26 ~ 2024-09-16",
            schedule: "6개월",
            goal: "수익 창출 및 펀딩",
            note: "이 콘텐츠는 재미를 최우선으로 두었습니다."
        }
    };
}
